class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :logged_in?

  before_filter :initialize_user

  protected

  def initialize_user
    @current_user = User.find_by_id(session[:user])
  end

  def logged_in?
    @current_user.is_a?(User)
  end
end
