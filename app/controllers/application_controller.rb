class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  attr_reader :page_info

  helper_method :admin?, :current_user, :page_info, :signed_in?, :page_for_sale?, :page_for_rent?

  before_action :initialize_website, :set_locale, :initialize_user, :page_defaults

  before_action :admin_required, only: [:restart, :precompile_assets]

  rescue_from ActionView::MissingTemplate, with: :render_html

  rescue_from ActionView::MissingTemplate, with: :render_html

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: :render_error
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActionController::RoutingError, with: :not_found
    rescue_from AbstractController::ActionNotFound, with: :not_found
  end

  def routing_error
    not_found
  end

  def restart
    clear_failed_jobs
    restart_script
    redirect_to cms_path, notice: "Application restarted."
  end

  # Removes Delayed Jobs from the job queue that have failed at least once.
  def clear_failed_jobs
    ActiveRecord::Base.connection.execute(
      "DELETE FROM delayed_jobs WHERE attempts > 0"
    )
  end

  def precompile_assets
    `bundle exec rake assets:precompile RAILS_ENV=production && touch tmp/restart.txt`
    redirect_to cms_path, notice: "Assets precompiled."
  end

  def sitemap
    @urls = [
      "/contact",
      "/enquiries/new",
      "/privacy",
      "/resorts/featured",
      "/sign_in",
      "/sign_up",
      "/terms",
      "/users/forgot_password",
      "/welcome/advertiser",
      "/welcome/estate-agent",
      "/welcome/letting-agent",
      "/welcome/other-business",
      "/welcome/property-owner",
    ].collect {|x| "https://" + request.domain + x}
    Country.with_visible_resorts.each do |country|
      country.visible_resorts.each do |resort|
        @urls << resort_url(resort)
        @urls << resort_guide_url(resort) if resort.has_resort_guide?
        @urls << gallery_resort_url(resort)
        @urls << piste_map_resort_url(resort) if resort.has_piste_maps?
        @urls << resort_property_rent_url(resort) unless resort.for_rent_count == 0
        @urls << resort_property_sale_url(resort) unless resort.for_sale_count == 0
        @urls << resort_property_new_developments_url(resort) unless resort.new_development_count == 0
      end
    end
    Property.where(publicly_visible: true).includes(:interhome_accommodation).find_each(batch_size: 500) do |property|
      @urls << if property.interhome_accommodation_id
        interhome_property_url(property.interhome_accommodation.permalink)
      else
        property_url(property)
      end
    end
  end

  # Returns +true+ if +user_agent+ is a known robot user agent.
  def bot?(user_agent)
    `cat #{Shellwords.escape(bot_file)} | grep #{Shellwords.escape(user_agent)}`.present?
  end

  def page_for_sale?
    request.env["PATH_INFO"].downcase.include? "sale"
  end

  def page_for_rent?
    request.env["PATH_INFO"] == "/" || request.env["PATH_INFO"].downcase.include?("rent")
  end

  protected

  def initialize_website
    @w = Website.first
    not_found if @w.nil?
  end

  def set_locale
    @lang = I18n.locale = extract_locale_from_subdomain || I18n.default_locale
  end

  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    parsed_locale && I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale : nil
  end

  def initialize_user
    current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user])
  end

  def page_defaults
    @footer_box = ""
    @destination = ""
    @page_info = Page.find_by(path: request.path)
    if @page_info
      @page_title = @page_info.title
      @meta_description = @page_info.description
      @meta_keywords = @page_info.keywords
      @page_content = @page_info.content
      @footer_box = @page_info.footer.content unless @page_info.footer.nil?
      @page_sidebar_html = @page_info.sidebar_html(@lang)
      @page_header_html = @page_info.header_html(@lang)
    end

    use_default_footer if @footer_box.blank?
  end

  def no_header!
    @no_header = true
  end

  def use_default_footer
    footer = Footer.find_by(name: "Default")
    @footer_box = footer.content unless footer.nil?
  end

  def user_required
    unless signed_in?
      redirect_to sign_in_path, notice: t("notices.sign_in_required")
    end
  end

  def admin_required
    unless admin?
      redirect_to sign_in_path, notice: t("notices.admin_required")
    end
  end

  def ssl_required
    if Rails.env == "production" && !request.ssl?
      flash.keep
      redirect_to protocol: "https://"
    end
  end

  def signed_in?
    current_user.is_a?(User)
  end

  def admin?
    signed_in? && current_user.role.admin?
  end

  def not_found(exception = nil)
    render file: "#{Rails.root}/public/404", formats: [:html], layout: false, status: 404
  end

  def render_error(exception)
    ExceptionNotifier::Notifier
      .exception_notification(request.env, exception)
      .deliver
    render file: "#{Rails.root}/public/500", layout: false, status: 500
  end

  def default_meta_description(options = {})
    options[:default] = ""
    key = "#{params[:controller]}_controller.meta_descriptions.#{params[:action]}"
    @meta_description = t(key, options) if @meta_description.blank?
  end

  def default_page_title(suggested_title)
    @page_title = suggested_title if @page_title.blank?
  end

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def owned_or_admin?(object)
    admin? || (signed_in? && object.user_id == current_user.id)
  end

  private

  def bot_file
    "bots.txt"
  end

  def render_html(exception)
    if request.format != "html"
      render formats: [:html]
    else
      raise exception
    end
  end

  def restart_script
    `./restart.sh`
  end
end
