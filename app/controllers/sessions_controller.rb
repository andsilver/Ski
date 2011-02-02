class SessionsController < ApplicationController
  def new
  end

  def create
    @current_user = User.find_by_email(params[:email])
    if @current_user
      session[:user] = @current_user.id
      redirect_to my_details_path
    else
      flash[:notice] = I18n.t('sign_in_invalid')
      redirect_to sign_in_path
    end
  end
end
