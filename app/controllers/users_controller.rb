class UsersController < ApplicationController
  before_action :user_required, only: [:first_advert, :show, :edit, :update]
  before_action :find_user, only: [:forgot_password_new, :forgot_password_change, :destroy]
  before_action :find_current_user_or_selected_user, only: [:edit, :update]

  def first_advert
    default_page_title t("users.first_advert")
  end

  def show
    default_page_title t("advertise")
  end

  def new
    default_page_title t("sign_up")
    @user = User.new
  end

  # +select_role+ is a helper action to allow simple HTML links to pre-choose
  # a role for signup.
  #
  # Example:
  #     <a href="/users/select_role?user[role_id]=2">Advertise</a>
  def select_role
    if params[:user] && params[:user][:role_id]
      stage_one
      render :new
    else
      redirect_to "/welcome/advertiser"
    end
  end

  def create
    stage_one

    if params[:stage] && params[:stage] == "1"
      render("new") && return
    end

    if @user.save
      session[:user] = @user.id
      UserNotifier.welcome(@user, params[:user][:password], request.host).deliver
      flash[:notice] = t("users.account_created")
      update_logo
      redirect_to after_create_path(@user)
    else
      render action: "new"
    end
  end

  def edit
    edit_breadcrumbs_and_heading
  end

  def update
    if admin?
      @user.coupon_id = params[:user][:coupon_id]
      @user.apply_price_override = params[:user][:apply_price_override]
      @user.price_override = params[:user][:price_override]
    end

    if @user.update_attributes(user_params)
      update_logo
      if admin?
        redirect_to admin_users_path, notice: t("notices.saved")
      else
        redirect_to my_details_path, notice: t("my_details_saved")
      end
    else
      edit_breadcrumbs_and_heading
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: t("notices.deleted")
  end

  def forgot_password
    default_page_title t("users.forgot_password.forgot_password")
    @heading_a = t("users.forgot_password.forgot_password")
  end

  def forgot_password_send
    default_page_title t("users.email_sent")
    @heading_a = t("users.email_sent")

    @user = User.find_by(email: params[:email])
    if @user.nil?
      flash[:notice] = "There is no user registered with that email address"
      redirect_to action: "forgot_password"
    else
      @user.forgot_password_token = User.generate_forgot_password_token
      @user.save
      UserNotifier.token(@user, request.host).deliver
    end
  end

  def forgot_password_new
    default_page_title t("users.choose_a_new_password")
    @heading_a = t("users.choose_a_new_password")
    forgot_password_params_ok?
  end

  def forgot_password_change
    if forgot_password_params_ok?
      @user.password = params[:password]
      @user.forgot_password_token = ""
      @user.save
      redirect_to sign_in_path, notice: t("users.password_changed")
    end
  end

  private

  def edit_breadcrumbs_and_heading
    if admin?
      @breadcrumbs = {"CMS" => cms_path, "Users" => users_path}
      @heading = @user.name
    else
      @breadcrumbs = {t("advertise") => advertise_path}
      @heading = t("users.my_details.my_details")
    end
  end

  def stage_one
    @user = User.new(user_params)
    @role = Role.find_by(id: params[:user][:role_id])
    if @role&.select_on_signup?
      @user.role_id = @role.id
    end
  end

  def after_create_path(user)
    if user.role.only_advertises_properties_for_sale?
      new_property_path(listing_type: Property::LISTING_TYPE_FOR_SALE)
    elsif user.role.only_advertises_properties_for_rent?
      new_property_path(listing_type: Property::LISTING_TYPE_FOR_RENT)
    else
      first_advert_path
    end
  end

  def update_logo
    return if params[:image].nil?

    @image = Image.new
    @image.user_id = @user.id
    @image.image = params[:image]

    begin
      if @image.save
        @user.image&.destroy
        @user.image_id = @image.id
        @user.save
      end
    rescue
    end
  end

  def forgot_password_params_ok?
    if @user.forgot_password_token.blank?
      redirect_to({action: "forgot_password"}, notice: t("users.enter_your_email_address"))
      return false
    elsif params[:t].nil? || (@user.forgot_password_token != params[:t])
      flash[:notice] = "The link you entered was invalid. This can happen if " \
        "you have re-requested a forgot password email or you have already " \
        "reset and changed your password."
      redirect_to action: "forgot_password"
      return false
    end
    true
  end

  def find_user
    @user = User.find(params[:id])
  end

  def find_current_user_or_selected_user
    @user = if admin? && params[:id]
      User.find(params[:id])
    else
      current_user
    end
  end

  def user_params
    params.require(:user).permit(
      :billing_city, :billing_country_id, :billing_location,
      :billing_postcode, :billing_street, :business_name, :description,
      :email, :enquiry_cc_emails, :first_name, :google_web_property_id,
      :last_name, :mobile, :password, :phone, :position,
      :terms_and_conditions, :website, :vat_country_id, :vat_number
    )
  end
end
