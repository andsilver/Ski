class BannerPricesController < ApplicationController
  before_filter :admin_required
  before_filter :no_browse_menu

  before_filter :find_banner_price, :only => [:edit, :update, :destroy]

  def index
    @banner_prices = BannerPrice.all
  end

  def new
    @banner_price = BannerPrice.new
  end

  def create
    @banner_price = BannerPrice.new(params[:banner_price])
    if @banner_price.save
      redirect_to banner_prices_path, :notice => t('notices.created')
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @banner_price.update_attributes(params[:banner_price])
      redirect_to banner_prices_path, :notice => t('notices.saved')
    else
      render 'edit'
    end
  end

  def destroy
    @banner_price.destroy
    redirect_to banner_prices_path, :notice => t('notices.deleted')
  end

  protected

  def find_banner_price
    @banner_price = BannerPrice.find(params[:id])
  end
end
