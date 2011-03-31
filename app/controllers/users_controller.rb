class UsersController < ApplicationController
  before_filter :admin_required, :only => [:index]
  before_filter :user_required, :except => [:new, :create]

  def index
    @users = User.all(:order => :email)
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
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
      redirect_to(advertiser_home_path, :notice => 'Your account was successfully created.')
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
end
