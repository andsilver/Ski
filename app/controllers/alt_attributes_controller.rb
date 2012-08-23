class AltAttributesController < ApplicationController
  before_filter :admin_required
  before_filter :find_alt_attribute, only: [:edit, :update, :show, :destroy]
  before_filter :no_browse_menu

  def index
    @alt_attributes = AltAttribute.order('path')
  end

  def new
    @alt_attribute = AltAttribute.new
  end

  def create
    @alt_attribute = AltAttribute.new(params[:alt_attribute])

    if @alt_attribute.save
      redirect_to(alt_attributes_path, notice: t('notices.created'))
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @alt_attribute.update_attributes(params[:alt_attribute])
      redirect_to(alt_attributes_path, notice: t('notices.saved'))
    else
      render 'edit'
    end
  end

  def destroy
    @alt_attribute.destroy
    redirect_to alt_attributes_path, notice: t('notices.deleted')
  end

  protected

  def find_alt_attribute
    @alt_attribute = AltAttribute.find(params[:id])
  end
end
