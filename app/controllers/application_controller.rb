class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :admin?, :signed_in?

  before_filter :initialize_website, :set_locale, :initialize_user, :page_defaults

  before_filter :admin_required, only: [:restart, :precompile_assets]

  rescue_from ActionView::MissingTemplate, with: :render_html

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: :render_error
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActionController::RoutingError, with: :not_found
    rescue_from ActionController::UnknownController, with: :not_found
  end

  def routing_error
    not_found
  end

  def restart
    `touch tmp/restart.txt` # assumes Phusion Passenger
    redirect_to cms_path, notice: 'Application restarted.'
  end

  def precompile_assets
    `bundle exec rake assets:precompile RAILS_ENV=production && touch tmp/restart.txt`
    redirect_to cms_path, notice: 'Assets precompiled.'
  end

  def sitemap
    domain = "#{request.subdomains.first}.#{request.domain}"
    @urls = [
      '/contact',
      '/enquiries/new',
      '/privacy',
      '/resorts/featured',
      '/sign_in',
      '/sign_up',
      '/terms',
      '/users/forgot_password',
      '/welcome/advertiser',
      '/welcome/estate-agent',
      '/welcome/hotelier',
      '/welcome/letting-agent',
      '/welcome/other-business',
      '/welcome/property-owner',
    ].collect{|x| 'http://' + domain + x}
    Country.with_visible_resorts.each do |country|
      @urls << country_url(country)
      country.visible_resorts.each do |resort|
        @urls << resort_url(resort)
        @urls << resort_guide_url(resort)
        @urls << gallery_resort_url(resort)
        @urls << piste_map_resort_url(resort)
        @urls << resort_property_hotels_path(resort) unless resort.hotel_count == 0
        @urls << resort_property_rent_url(resort) unless resort.for_rent_count == 0
        @urls << resort_property_sale_url(resort) unless resort.for_sale_count == 0
        @urls << resort_property_new_developments_url(resort) unless resort.new_development_count == 0
      end
    end
    Property.find_each(batch_size: 500, conditions: {publicly_visible: true}, include: :interhome_accommodation) do |property|
      if property.interhome_accommodation_id
        @urls << interhome_property_url(property.interhome_accommodation.permalink)
      else
        @urls << property_url(property)
      end
    end
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
    @current_user = current_user
    @unregistered_user = UnregisteredUser.find_by_id(session[:unregistered_user])
  end

  def current_user
    User.find_by_id(session[:user])
  end

  def page_defaults
    @footer_box = ''
    page = Page.find_by_path(request.path)
    if page
      @page_title = page.title
      @meta_description = page.description
      @page_content = page.content
      @footer_box = page.footer.content unless page.footer.nil?
      @banner_advert_html = page.banner_advert_html unless page.banner_advert_html.blank?
    end

    use_default_footer if @footer_box.blank?
  end

  def use_default_footer
    footer = Footer.find_by(name: 'Default')
    @footer_box = footer.content unless footer.nil?
  end

  def user_required
    unless signed_in?
      redirect_to sign_in_path, notice: t('notices.sign_in_required')
    end
  end

  def unregistered_user_required
    if(!@unregistered_user)
      @unregistered_user = UnregisteredUser.create!
      session[:unregistered_user] = @unregistered_user.id
    end
  end

  def admin_required
    unless admin?
      redirect_to sign_in_path, notice: t('notices.admin_required')
    end
  end

  def ssl_required
    if Rails.env == 'production' && !request.ssl?
      flash.keep
      redirect_to protocol: 'https://'
    end
  end

  def signed_in?
    @current_user.is_a?(User)
  end

  def admin?
    signed_in? and @current_user.role.admin?
  end

  def not_found(exception = nil)
    render "#{Rails.root.to_s}/public/404", formats: [:html], layout: false, status: 404
  end

  def render_error(exception)
    ExceptionNotifier::Notifier
      .exception_notification(request.env, exception)
      .deliver
    render "#{Rails.root.to_s}/public/500", layout: false, status: 500
  end

  def default_meta_description(options = {})
    options[:default] = ''
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

    def render_html(exception)
      if request.format != 'html'
        render formats: [:html]
      else
        raise exception
      end
    end
end
