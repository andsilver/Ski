class ResortsController < ApplicationController
  before_action :set_resort, only: [:directory, :feature, :gallery, :how_to_get_there, :piste_map, :piste_map_full_size, :resort_guide, :show, :summer_holidays]
  before_action :find_featured_properties, only: [:resort_guide, :show, :summer_holidays]

  def show
    default_page_title t('resorts_controller.titles.show', resort: @resort, country: @resort.country)
    default_meta_description(resort: @resort, country: @resort.country)
    @heading_a = t('resorts_controller.resort_information_heading', resort: @resort)
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

  def feature; end

  def summer_holidays; end

  def how_to_get_there; end

  protected

    def set_resort
      @resort = Resort.find_by(slug: params[:id])
      if admin?
        redirect_to(admin_resorts_path, notice: t('resorts_controller.not_found')) unless @resort
      else
        not_found if !@resort || !@resort.visible?
      end
    end

    def find_featured_properties
      @featured_properties = Property.order('RAND()').limit(9).where(publicly_visible: true, resort_id: @resort.id)
    end
end
