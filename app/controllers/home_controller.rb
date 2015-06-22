class HomeController < ApplicationController
  before_action :set_resort_and_region_from_place_name, only: [:search]

  def index
    @featured_properties = @w.featured_properties
  end

  def search
    if @resort
      redirect_to @resort
    elsif @region
      redirect_to @region
    else
      not_found
    end
  end

  def country_options_for_quick_search
    if params[:holiday_type_id].blank?
      @countries = []
    else
      @countries = HolidayType.find(params[:holiday_type_id]).visible_country_brochures.map { |b| b.brochurable }
    end
    render layout: false
  end

  # Despite the name, this action populates @resorts with both Regions and
  # Resorts.
  def resort_options_for_quick_search
    if params[:country_id].blank?
      @resorts = []
    else
      country = Country.find(params[:country_id])
      if params[:holiday_type_id].blank?
        @resorts = country.visible_regions + country.visible_resorts
      else
        @resorts = country.region_brochures(params[:holiday_type_id]).map { |b| b.brochurable } + country.resort_brochures(params[:holiday_type_id]).map { |b| b.brochurable }
      end
    end
    render layout: false
  end

  def contact
    default_page_title t('contact')
  end

  def privacy
    default_page_title t('privacy')
  end

  def terms
    default_page_title t('terms')
  end

  private

    def set_resort_and_region_from_place_name
      if params[:place_name]
        @resort ||= Resort.find_by(name: params[:place_name])
        @region ||= Region.find_by(name: params[:place_name])
      end
    end
end
