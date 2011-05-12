class PropertyVolumeDiscountsController < ApplicationController
  before_filter :admin_required
  before_filter :find_property_volume_discounts, :only => [:edit, :update]

  def index
    @property_volume_discounts = PropertyVolumeDiscount.all(:order => :current_property_number)
  end

  def new
    @property_volume_discount = PropertyVolumeDiscount.new
  end

  def create
    @property_volume_discount = PropertyVolumeDiscount.new(params[:property_volume_discount])

    if @property_volume_discount.save
      redirect_to(property_volume_discounts_path, :notice => 'Property volume discount created.')
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @propery_volume_discount.update_attributes(params[:property_volume_discount])
      redirect_to(property_volume_discounts_path, :notice => 'Saved')
    else
      render "edit"
    end
  end

  protected

  def find_property_volume_discount
    @property_volume_discount = PropertyVolumeDiscount.find(params[:id])
  end
end
