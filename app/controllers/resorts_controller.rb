class ResortsController < ApplicationController
  before_filter :admin_required, except: [:show, :directory, :feature, :featured, :piste_map, :piste_map_full_size, :resort_guide, :gallery, :summer_holidays]
  before_filter :find_resort, only: [:edit, :update, :show, :destroy, :resort_guide, :directory, :feature, :piste_map, :piste_map_full_size, :gallery, :summer_holidays]
  before_filter :no_browse_menu, except: [:show, :feature, :directory, :resort_guide, :summer_holidays]
  before_filter :find_featured_properties, only: [:show, :summer_holidays]

  def index
    @countries = Country.with_resorts
  end

  def new
    @resort = Resort.new
    @resort.country_id = session[:last_country_id] unless session[:last_country_id].nil?
  end

  def create
    @resort = Resort.new(params[:resort])

    if @resort.save
      session[:last_country_id] = @resort.country_id
      redirect_to(resorts_path, notice: t('notices.created'))
    else
      render action: 'new'
    end
  end

  def edit
    set_image_mode

    @interhome_place_resort = InterhomePlaceResort.new(resort_id: @resort.id)
  end

  def update
    if @resort.update_attributes(params[:resort])
      redirect_to(edit_resort_path(@resort), notice: t('notices.saved'))
    else
      @interhome_place_resort = InterhomePlaceResort.new(resort_id: @resort.id)
      render action: 'edit'
    end
  end

  def show
    default_page_title t('resorts_controller.titles.show', resort: @resort, country: @resort.country)
    default_meta_description(resort: @resort, country: @resort.country)
    @heading_a = t('resorts_controller.resort_information_heading', resort: @resort)
  end

  def destroy
    @resort.destroy

    redirect_to(resorts_url)
  end

  def resort_guide
    default_page_title t('resorts_controller.titles.resort_guide', resort: @resort, country: @resort.country)
    default_meta_description(resort: @resort, country: @resort.country)
    @heading_a = render_to_string(partial: 'detail_heading').html_safe
  end

  def directory
    @heading_a = t('resorts_controller.titles.directory', resort: @resort, country: @resort.country)
    default_page_title @heading_a
    default_meta_description(resort: @resort, country: @resort.country)
    @categories = Category.order('name')
  end

  def featured
    @heading_a = t('featured_resorts')
  end

  def piste_map
    default_page_title t('resorts_controller.titles.piste_map', resort: @resort, country: @resort.country)
    default_meta_description(resort: @resort, country: @resort.country)
    @heading_a = render_to_string(partial: 'piste_map_heading').html_safe
  end

  def piste_map_full_size
    default_meta_description(resort: @resort, country: @resort.country)
    @heading_a = render_to_string(partial: 'piste_map_heading').html_safe
    @map = params[:map]
    render layout: nil
  end

  def gallery
    default_page_title t('resorts_controller.titles.gallery', resort: @resort, country: @resort.country)
    @heading_a = render_to_string(partial: 'gallery_heading').html_safe
  end

  def feature
  end

  def summer_holidays
    @heading_a = t('resorts_controller.titles.summer_holidays', resort: @resort)
    default_page_title @heading_a
    default_meta_description(resort: @resort, country: @resort.country)
  end

  protected

  def find_resort
    @resort = Resort.find_by_id(params[:id])
    if admin?
      redirect_to(resorts_path, notice: t('resorts_controller.not_found')) unless @resort
    else
      not_found if !@resort || !@resort.visible?
    end
  end

  def set_image_mode
    session[:image_mode] = 'resort'
    session[:resort_id] = @resort.id
  end

  def find_featured_properties
    @featured_properties = Property.order('RAND()').limit(12).where(publicly_visible: true, resort_id: @resort.id)
  end
end
