class DirectoryAdvertsController < ApplicationController
  before_filter :no_browse_menu
  before_filter :user_required
  before_filter :find_directory_advert_for_current_user, :only => [:edit, :update, :advertise_now]
  before_filter :set_cache_buster, :only => [:new, :create]

  def new
    @directory_advert = DirectoryAdvert.new
  end

  def show
    @directory_advert = DirectoryAdvert.find(params[:id])
    if @directory_advert.current_advert.nil?
      not_found
    else
      @directory_advert.current_advert.record_view
    end
  end

  def create
    @directory_advert = DirectoryAdvert.new(params[:directory_advert])

    @directory_advert.user_id = @current_user.id

    update_user_details

    if @directory_advert.save
      advert = Advert.new_for(@directory_advert)
      advert.months = 3
      advert.save!
      set_image_mode
      redirect_to new_image_path, :notice => "Your directory advert was successfully created. Now let's upload the your business photo or logo."
    else
      render "new"
    end
  end

  def edit
    set_image_mode
  end

  def update
    update_user_details
    if @directory_advert.update_attributes(params[:directory_advert])
      flash[:notice] = "Your directory advert was successfully updated."
      if @current_user.basket_contains? @directory_advert
        redirect_to basket_path
      else
        redirect_to my_adverts_path
      end
    else
      render "edit"
    end
  end

  def advertise_now
    create_advert
    redirect_to(basket_path, :notice => 'Your directory advert has been added to your basket.')
  end

  protected

  def find_directory_advert_for_current_user
    @directory_advert = DirectoryAdvert.find_by_id_and_user_id(params[:id], @current_user.id)
  end

  def update_user_details
    @current_user.business_name = params[:business_name]
    @current_user.website = params[:website]
    @current_user.description = params[:description]
    @current_user.save
  end

  def create_advert
    advert = Advert.new_for(@directory_advert)
    advert.months = 3
    advert.save!
  end

  def set_image_mode
    session[:image_mode] = 'directory_advert'
    session[:directory_advert_id] = @directory_advert.id
  end
end
