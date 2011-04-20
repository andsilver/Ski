class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :admin?, :signed_in?

  before_filter :initialize_website, :initialize_user, :page_defaults

  protected

  def initialize_website
    @w = Website.first
    not_found if @w.nil?
  end

  def initialize_user
    @current_user = User.find_by_id(session[:user])
  end

  def page_defaults
    @browse_menu = true
  end

  def no_browse_menu
    @browse_menu = false
  end

  def user_required
    unless signed_in?
      flash[:notice] = I18n.t('sign_in_required')
      redirect_to sign_in_path
    end
  end

  def admin_required
    unless admin?
      flash[:notice] = 'You need to be logged in as an administrator to do that.'
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
end
