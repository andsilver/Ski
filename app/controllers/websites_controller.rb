class WebsitesController < ApplicationController
  before_filter :admin_required
  before_filter :no_browse_menu
  before_filter :find_website, :only => [:edit, :edit_prices, :update]

  def edit
  end

  def edit_prices
  end

  def update
    if @website.update_attributes(params[:website])
      if params[:website][:banner_advert_price]
        redirect_to(banner_directory_advert_prices_path, :notice => t('notices.saved'))
      else
        redirect_to(edit_website_path(@website), :notice => t('notices.saved'))
      end
    else
      render "edit"
    end
  end

  protected

  def find_website
    @website = @w
  end
end
