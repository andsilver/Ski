class UsersController < ApplicationController
  before_filter :no_browse_menu
  before_filter :admin_required, :only => [:index]
  before_filter :user_required, :only => [:show, :edit, :update]
  before_filter :find_user, :only => [:forgot_password_new, :forgot_password_change]

  def index
    @users = User.all(:order => :email)
  end

  def show
  end

  def new
    @heading_a = t 'sign_up'
    @user = User.new
  end

  def create
    @heading_a = t 'sign_up'
    @user = User.new(params[:user])
    @role = Role.find_by_id(params[:user][:role_id])
    if @role && @role.select_on_signup?
      @user.role_id = @role.id
    end

    if params[:stage] && params[:stage]=="1"
      render "new" and return
    end

    if @user.save
      session[:user] = @user.id
      redirect_to(advertise_path, :notice => 'Your account was successfully created.')
    else
      render :action => "new"
    end
  end

  def edit
    @user = @current_user
  end

  def update
    @user = User.find(params[:id])

    if admin?
      @user.coupon_id = params[:user][:coupon_id]
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(my_details_path, :notice => I18n.t('my_details_saved')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def forgot_password
  end
  
  def forgot_password_send
    @user = User.find_by_email(params[:email])
    if @user.nil?
      flash[:notice] = "There is no user registered with that email address"
      redirect_to :action => "forgot_password"
    else
      @user.forgot_password_token = User.generate_forgot_password_token
      @user.save
      UserNotifier.token(@user, request.host).deliver
    end
  end

  def forgot_password_new
    forgot_password_params_ok?
  end
  
  def forgot_password_change
    if forgot_password_params_ok?
      @user.password = params[:password]
      @user.forgot_password_token = ''
      @user.save
      flash[:notice] = 'Your password has been changed'
      redirect_to sign_in_path
    end
  end
  
  private
  
  def forgot_password_params_ok?
    if @user.forgot_password_token.blank?
      flash[:notice] = "Please enter your email address below"
      redirect_to :action => "forgot_password"
      return false
    elsif params[:t].nil? or @user.forgot_password_token != params[:t]
      flash[:notice] = "The link you entered was invalid. This can happen if you have re-requested " +
        "a forgot password email or you have already reset and changed your password."
      redirect_to :action => "forgot_password"
      return false
    end
    true
  end

  def find_user
    @user = User.find(params[:id])
  end
end
