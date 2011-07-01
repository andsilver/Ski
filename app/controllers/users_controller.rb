class UsersController < ApplicationController
  before_filter :no_browse_menu
  before_filter :admin_required, :only => [:index]
  before_filter :user_required, :only => [:first_advert, :show, :edit, :update]
  before_filter :find_user, :only => [:forgot_password_new, :forgot_password_change]
  before_filter :find_current_user_or_selected_user, :only => [:edit, :update]

  def index
    @users = User.all(:order => :email)
  end

  def first_advert
    default_page_title t('users.first_advert')
  end

  def show
    default_page_title t('advertise')
    @heading_a = t('users.advertiser_account', :name => @current_user.name)
  end

  def new
    default_page_title t('sign_up')
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
      UserNotifier.welcome(@user, request.host).deliver
      flash[:notice] = t('users.account_created')
      if @user.role.only_advertises_properties_for_sale?
        redirect_to new_property_path(:for_sale => true)
      elsif @user.role.only_advertises_properties_for_rent?
        redirect_to new_property_path
      else
        redirect_to(first_advert_path)
      end
    else
      render :action => "new"
    end
  end

  def edit
    @heading_a = admin? ?
      render_to_string(:partial => 'edit_admin_heading', :locals => {:user => @user}).html_safe :
      render_to_string(:partial => 'edit_user_heading').html_safe
  end

  def update
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
    default_page_title t('users.forgot_password')
    @heading_a = t('users.forgot_password')
  end
  
  def forgot_password_send
    default_page_title t('users.email_sent')
    @heading_a = t('users.email_sent')

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
    default_page_title t('users.choose_a_new_password')
    @heading_a = t('users.choose_a_new_password')
    forgot_password_params_ok?
  end
  
  def forgot_password_change
    if forgot_password_params_ok?
      @user.password = params[:password]
      @user.forgot_password_token = ''
      @user.save
      redirect_to sign_in_path, :notice => t('users.password_changed')
    end
  end
  
  private

  def forgot_password_params_ok?
    if @user.forgot_password_token.blank?
      redirect_to :action => "forgot_password", notice => t('users.enter_your_email_address')
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

  def find_current_user_or_selected_user
    if admin? && params[:id]
      @user = User.find(params[:id])
    else
      @user = @current_user
    end
  end
end
