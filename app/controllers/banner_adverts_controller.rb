class BannerAdvertsController < ApplicationController
  CURRENTLY_ADVERTISED = ["id IN (SELECT adverts.banner_advert_id FROM adverts WHERE adverts.banner_advert_id=banner_adverts.id AND adverts.expires_at > NOW())"]

  before_filter :no_browse_menu
  before_filter :find_banner_advert_for_user, :only => [:edit, :show, :update, :advertise_now]

  def create
    @banner_advert = BannerAdvert.new(params[:banner_advert])
    @banner_advert.user_id = @current_user.id

    if @banner_advert.save
      Advert.create_for(@banner_advert)
      redirect_to new_image_path, :notice => t('banner_adverts_controller.created')
    else
      render :action => "new"
    end
  end

  def update
    if @banner_advert.update_attributes(params[:banner_advert])
      redirect_to my_adverts_path, :notice => t('banner_adverts_controller.saved')
    else
      render "edit"
    end
  end

  protected

  def find_banner_advert_for_user
    @banner_advert = BannerAdvert.find_by_id_and_user_id(params[:id], @current_user.id)
    not_found unless @banner_advert
  end
end
