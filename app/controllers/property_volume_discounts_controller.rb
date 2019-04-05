class PropertyVolumeDiscountsController < ApplicationController
  before_action :admin_required
  before_action :find_property_volume_discount, only: [:edit, :update, :destroy]

  layout "admin"

  def index
    @property_volume_discounts = PropertyVolumeDiscount.order("current_property_number")
  end

  def new
    @property_volume_discount = PropertyVolumeDiscount.new
  end

  def create
    @property_volume_discount = PropertyVolumeDiscount.new(property_volume_discount_params)

    if @property_volume_discount.save
      redirect_to(property_volume_discounts_path, notice: t("notices.created"))
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @property_volume_discount.update_attributes(property_volume_discount_params)
      redirect_to(property_volume_discounts_path, notice: t("notices.saved"))
    else
      render "edit"
    end
  end

  def destroy
    @property_volume_discount.destroy
    redirect_to(property_volume_discounts_path, notice: t("notices.deleted"))
  end

  protected

  def find_property_volume_discount
    @property_volume_discount = PropertyVolumeDiscount.find(params[:id])
  end

  def property_volume_discount_params
    params.require(:property_volume_discount).permit(:current_property_number, :discount_amount, :discount_percentage)
  end
end
