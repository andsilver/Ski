class SessionsController < ApplicationController
  def new
  end

  def create
    @current_user = User.find_by_email(params[:email])
    session[:user] = @current_user.id
    redirect_to my_details_path
  end
end
