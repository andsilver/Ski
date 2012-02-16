# coding: utf-8

class DirectoryAdvertsController < ApplicationController
  VALID_BANNER_SIZES = [
    [160, 200]
  ]

  before_filter :no_browse_menu
  before_filter :user_required, :except => [:show, :click]
  before_filter :admin_required, :only => [:index]
  before_filter :find_directory_advert_for_current_user, :only => [:edit, :update, :advertise_now]
  before_filter :set_cache_buster, :only => [:new, :create]

  def index
    @directory_adverts = DirectoryAdvert.all
  end

  def new
    @directory_advert = DirectoryAdvert.new
    @directory_advert.url = @current_user.website
    @directory_advert.description = @current_user.description
    @directory_advert.business_name = @current_user.business_name
  end

  def show
    @directory_advert = DirectoryAdvert.find(params[:id])
    if @directory_advert.current_advert.nil?
      not_found
    else
      default_page_title("#{@directory_advert.business_name}, #{t(@directory_advert.category.name)} in #{@directory_advert.resort.name}, #{@directory_advert.resort.country.name}")
      @heading_a = render_to_string(:partial => 'show_directory_advert_heading').html_safe
      @directory_advert.current_advert.record_view
    end
  end

  def create
    @directory_advert = DirectoryAdvert.new(params[:directory_advert])

    @directory_advert.user_id = @current_user.id

    if @directory_advert.save
      update_images
      create_advert
      redirect_to basket_path, :notice => t('directory_adverts_controller.created')
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @directory_advert.update_attributes(params[:directory_advert])
      flash[:notice] = t('directory_adverts_controller.saved')

      update_images

      if @current_user.basket_contains? @directory_advert
        redirect_to basket_path
      else
        redirect_to my_adverts_path
      end
    else
      render "edit"
    end
  end

  def destroy
    @directory_advert = DirectoryAdvert.find(params[:id])
    @directory_advert.destroy
    redirect_to(directory_adverts_path, :notice => t('notices.deleted'))
  end

  def advertise_now
    create_advert
    redirect_to(basket_path, :notice => t('directory_adverts_controller.added_to_basket'))
  end

  def click
    @directory_advert = DirectoryAdvert.find(params[:id])
    @directory_advert.clicks += 1
    @directory_advert.save
    redirect_to @directory_advert.url
  end

  protected

  def update_images
    begin
      banner_image = Image.new(:image => params['banner_image'])
      banner_image.user_id = @current_user.id

      if banner_image.save
        if valid_banner_size?(banner_image)
          @directory_advert.banner_image.destroy unless @directory_advert.banner_image.nil?
          @directory_advert.banner_image_id = banner_image.id
          @directory_advert.record_dimensions(banner_image.dimensions)
          @directory_advert.save
        else
          banner_image.destroy
          flash[:notice] = t('images_controller.invalid_dimensions')
        end
      end
    rescue
      logger.info "Failed to update banner image for DirectoryAdvert ##{@directory_advert.id}"
    end

    begin
      directory_image = Image.new(:image => params[:image])
      directory_image.user_id = @current_user.id

      if directory_image.save
        @directory_advert.image.destroy unless @directory_advert.image.nil?
        @directory_advert.image_id = directory_image.id
        @directory_advert.save
      end
    rescue
      logger.info "Failed to update directory image for DirectoryAdvert ##{@directory_advert.id}"
    end
  end

  def valid_banner_size?(image)
    VALID_BANNER_SIZES.include? image.dimensions
  end

  def find_directory_advert_for_current_user
    @directory_advert = DirectoryAdvert.find_by_id_and_user_id(params[:id], @current_user.id)
    not_found unless @directory_advert
  end

  def create_advert
    advert = Advert.new_for(@directory_advert)
    advert.months = @directory_advert.default_months
    advert.save!
  end
end
