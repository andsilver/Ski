class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :admin?, :signed_in?

  before_filter :initialize_website, :set_locale, :initialize_user, :page_defaults

  def sitemap
    domain = "#{request.subdomains.first}.#{request.domain}"
    @urls = [
      '/contact',
      '/enquiries/new',
      '/links',
      '/privacy',
      '/resorts/featured',
      '/sign_in',
      '/sign_up',
      '/terms',
      '/users/forgot_password',
      '/welcome/advertiser',
      '/welcome/estate-agent',
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
        @urls << resort_property_rent_url(resort)
        @urls << resort_property_sale_url(resort)
        @urls << resort_property_new_developments_url(resort)
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
    @current_user = User.find_by_id(session[:user])
    @unregistered_user = UnregisteredUser.find_by_id(session[:unregistered_user])
  end

  def page_defaults
    @browse_menu = true
    @footer_box = ''
    page = Page.find_by_path(request.path)
    if page
      @page_title = page.title
      @meta_description = page.description
      @meta_keywords = page.keywords
      @footer_box = page.footer.content unless page.footer.nil?
      unless page.fixed_banner_image_filename.blank?
        @fixed_banner_image_path = "/fixed-banners/" + page.fixed_banner_image_filename
        @fixed_banner_target_url = page.fixed_banner_target_url
      end
    end
  end

  def no_browse_menu
    @browse_menu = false
  end

  def user_required
    unless signed_in?
      flash[:notice] = t('notices.sign_in_required')
      redirect_to sign_in_path
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
      flash[:notice] = t('notices.admin_required')
      redirect_to sign_in_path
    end
  end

  def signed_in?
    @current_user.is_a?(User)
  end

  def admin?
    signed_in? and @current_user.role.admin?
  end

  def not_found
    render :file => "#{Rails.root.to_s}/public/404.html", :layout => false, :status => 404
  end

  def default_page_title suggested_title
    @page_title = suggested_title if @page_title.blank?
  end

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
