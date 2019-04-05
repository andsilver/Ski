class PropertyBasePricesController < ApplicationController
  before_action :admin_required
  before_action :find_property_base_price, only: [:edit, :update, :destroy]

  layout "admin"

  def index
    @property_base_prices = PropertyBasePrice.order("number_of_months")
  end

  def new
    @property_base_price = PropertyBasePrice.new
  end

  def create
    @property_base_price = PropertyBasePrice.new(property_base_price_params)

    if @property_base_price.save
      redirect_to(property_base_prices_path, notice: t("notices.created"))
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @property_base_price.update_attributes(property_base_price_params)
      redirect_to(property_base_prices_path, notice: t("notices.saved"))
    else
      render "edit"
    end
  end

  def destroy
    @property_base_price.destroy
    redirect_to(property_base_prices_path, notice: t("notices.deleted"))
  end

  protected

  def find_property_base_price
    @property_base_price = PropertyBasePrice.find(params[:id])
  end

  def property_base_price_params
    params.require(:property_base_price).permit(:number_of_months, :price)
  end
end
