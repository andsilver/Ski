module Admin
  class CouponsController < AdminController
    before_action :set_coupon, only: %i[edit update destroy]

    def index
      @coupons = Coupon.order("code")
    end

    def new
      @coupon = Coupon.new
    end

    def create
      @coupon = Coupon.new(coupon_params)

      if @coupon.save
        redirect_to(admin_coupons_path, notice: t("notices.created"))
      else
        render "new"
      end
    end

    def edit
    end

    def update
      if @coupon.update_attributes(coupon_params)
        redirect_to(admin_coupons_path, notice: t("notices.saved"))
      else
        render "edit"
      end
    end

    def destroy
      @coupon.destroy
      redirect_to admin_coupons_path, notice: t("notices.deleted")
    end

    protected

    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    def coupon_params
      params.require(:coupon).permit(:code, :expires_on, :number_of_adverts, :percentage_off)
    end
  end
end
