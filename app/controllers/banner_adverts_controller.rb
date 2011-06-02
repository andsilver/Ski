class BannerAdvertsController < ApplicationController
  CURRENTLY_ADVERTISED = ["id IN (SELECT adverts.banner_advert_id FROM adverts WHERE adverts.banner_advert_id=banner_adverts.id AND adverts.expires_at > NOW())"]

  before_filter :no_browse_menu
  before_filter :user_required
  before_filter :find_banner_advert_for_user, :only => [:edit, :update, :advertise_now]

  def new
    @banner_advert = BannerAdvert.new
    @banner_advert.url = @current_user.website
  end

  def edit
    set_image_mode
  end

  def create
    @banner_advert = BannerAdvert.new(params[:banner_advert])
    @banner_advert.user_id = @current_user.id

    if @banner_advert.save
      Advert.create_for(@banner_advert)
      set_image_mode
      redirect_to new_image_path, :notice => "Your banner advert was successfully created. Now let's upload the banner image."
    else
      render :action => "new"
    end
  end

  def update
    if @banner_advert.update_attributes(params[:banner_advert])
      flash[:notice] = "Your banner advert details have been saved."
      redirect_to my_adverts_path
    else
      render "edit"
    end
  end

  def advertise_now
    Advert.create_for(@banner_advert)
    redirect_to(basket_path, :notice => 'Your banner advert has been added to your basket.')
  end

  def click
    @banner_advert = BannerAdvert.find(params[:id])
    @banner_advert.clicks += 1
    @banner_advert.save
    redirect_to @banner_advert.url
  end

  protected

  def find_banner_advert_for_user
    @banner_advert = BannerAdvert.find_by_id_and_user_id(params[:id], @current_user.id)
    not_found unless @banner_advert
  end

  def set_image_mode
    session[:image_mode] = 'banner_advert'
    session[:banner_advert_id] = @banner_advert.id
  end
end