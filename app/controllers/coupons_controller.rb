class CouponsController < ApplicationController
  before_filter :admin_required
  before_filter :no_browse_menu
  before_filter :find_coupon, :only => [:edit, :update]

  def index
    @coupons = Coupon.all(:order => :code)
  end

  def new
    @coupon = Coupon.new
  end

  def create
    @coupon = Coupon.new(params[:coupon])

    if @coupon.save
      redirect_to(coupons_path, :notice => 'Coupon created.')
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @coupon.update_attributes(params[:coupon])
      redirect_to(coupons_path, :notice => 'Saved')
    else
      render "edit"
    end
  end

  protected

  def find_coupon
    @coupon = Coupon.find(params[:id])
  end
end
