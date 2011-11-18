class CouponsController < ApplicationController
  before_filter :admin_required, :except => [:apply_code]
  before_filter :no_browse_menu
  before_filter :find_coupon, :only => [:edit, :update]
  before_filter :user_required, :only => [:apply_code]

  def index
    @coupons = Coupon.all(:order => :code)
  end

  def new
    @coupon = Coupon.new
  end

  def create
    @coupon = Coupon.new(params[:coupon])

    if @coupon.save
      redirect_to(coupons_path, :notice => t('notices.created'))
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @coupon.update_attributes(params[:coupon])
      redirect_to(coupons_path, :notice => t('notices.saved'))
    else
      render "edit"
    end
  end

  def apply_code
    if params[:code].blank?
      notice = I18n.t('coupons_controller.enter_a_coupon_code')
    else
      coupon = Coupon.find_by_code(params[:code])
      if coupon
        if coupon.expired?
          notice = I18n.t('coupons_controller.coupon_code_expired')
        else
          @current_user.coupon = coupon
          @current_user.save
          notice = I18n.t('coupons_controller.coupon_code_applied')
        end
      else
        notice = I18n.t('coupons_controller.coupon_code_not_recognised')
      end
    end
    redirect_to basket_path, :notice => notice
  end

  protected

  def find_coupon
    @coupon = Coupon.find(params[:id])
  end
end
