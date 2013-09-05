# coding: utf-8

class DirectoryAdvertsController < ApplicationController
  VALID_BANNER_SIZES = [
    [160, 200]
  ]

  before_filter :user_required, except: [:show, :click]
  before_filter :admin_required, only: [:index]
  layout 'admin', only: [:index]
  before_filter :find_directory_advert_for_current_user, only: [:edit, :update, :advertise_now]
  before_filter :set_cache_buster, only: [:new, :create]

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
    @directory_advert = DirectoryAdvert.find_by(id: params[:id])
    if @directory_advert.nil?
      not_found
    elsif @directory_advert.current_advert.nil? && !admin?
      not_found
    else
      default_page_title("#{@directory_advert.business_name}, #{t(@directory_advert.category.name)} in #{@directory_advert.resort.name}, #{@directory_advert.resort.country.name}")
      @heading_a = render_to_string(partial: 'show_directory_advert_heading').html_safe
      @directory_advert.current_advert.record_view if @directory_advert.current_advert
    end
  end

  def create
    resort_ids = params[:directory_advert][:resort_id]
    is_banner_advert = params[:directory_advert].delete(:is_banner_advert) || false

    resort_ids.each do |resort_id|
      next if resort_id == ''

      params[:directory_advert].delete(:resort_id)
      @directory_advert = DirectoryAdvert.new(directory_advert_params)
      @directory_advert.resort_id = resort_id
      @directory_advert.is_banner_advert = is_banner_advert

      @directory_advert.user_id = @current_user.id

      if @directory_advert.save
        update_images
        create_advert
      else
        render "new" and return
      end
    end
    redirect_to basket_path, notice: t('directory_adverts_controller.created')
  end

  def edit
  end

  def update
    if @directory_advert.update_attributes(directory_advert_params)
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

    if owned_or_admin?(@directory_advert)
      @directory_advert.destroy
      flash.notice = t('notices.deleted')
      redirect_to(admin? ? directory_adverts_path : my_adverts_path)
    else
      not_found
    end
  end

  def advertise_now
    create_advert
    redirect_to(basket_path, notice: t('directory_adverts_controller.added_to_basket'))
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
      banner_image = Image.new(image: params['banner_image'])
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
      directory_image = Image.new(image: params[:image])
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
    @directory_advert = DirectoryAdvert.find_by(id: params[:id], user_id: @current_user.id)
    not_found unless @directory_advert
  end

  def create_advert
    advert = Advert.new_for(@directory_advert)
    advert.months = @directory_advert.default_months
    advert.save!
  end

  def directory_advert_params
    params.require(:directory_advert).permit(:business_address, :business_name, :category_id, :description, :opening_hours, :phone, :postcode, :resort_id, :strapline, :url)
  end
end
