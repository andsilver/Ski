class SessionsController < ApplicationController
  before_filter :no_browse_menu

  def new
  end

  def create
    @current_user = User.authenticate(params[:email], params[:password])
    if @current_user
      session[:user] = @current_user.id
      flash[:notice] = 'Welcome back, ' + @current_user.name
      if @current_user.role.admin?
        redirect_to cms_path
      else
        redirect_to advertise_path
      end
    else
      redirect_to sign_in_path, :notice => I18n.t('sign_in_invalid')
    end
  end

  def destroy
    reset_session
    flash[:notice] = I18n.t('signed_out')
    redirect_to root_path
  end
end
