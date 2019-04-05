class SessionsController < ApplicationController
  before_action :admin_required, only: [:switch_user]

  def new
  end

  def create
    @current_user = User.authenticate(params[:email], params[:password])
    if @current_user
      set_user
    else
      redirect_to sign_in_path, notice: t("sign_in_invalid")
    end
  end

  # Ends the current session.
  #
  # If the user is an admin assuming the role of another user then the user
  # is signed back into their admin account.
  #
  # If +redirect_to+ param is set then the user is redirected to this URL,
  # otherwise the user is redirected back to the sign in page.
  def destroy
    if session[:admin]
      @current_user = User.find(session[:admin])
      set_user
    else
      reset_session
      flash[:notice] = t("signed_out")
      if params[:redirect_to]
        redirect_to params[:redirect_to]
      else
        redirect_to action: "new"
      end
    end
  end

  def switch_user
    admin_id = @current_user.id
    @current_user = User.find(params[:user_id])
    set_user
    session[:admin] = admin_id
  end

  protected

  def set_user
    reset_session
    session[:user] = @current_user.id
    flash[:notice] = t("sessions_controller.welcome_back", name: @current_user.first_name)
    if @current_user.role.admin?
      redirect_to cms_path
    else
      redirect_to advertise_path
    end
  end
end
