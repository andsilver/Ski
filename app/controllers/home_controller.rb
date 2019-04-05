# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :set_resort_and_region_from_place_name,
    only: %i[search search_sales]

  def index
    @featured_properties = @w.featured_properties
  end

  def search
    if @resort
      start_date = params[:start_date].present? ? params[:start_date].to_date.strftime("%Y.%m.%d") : nil
      end_date = params[:end_date].present? ? params[:end_date].to_date.strftime("%Y.%m.%d") : nil
      redirect_to resort_property_rent_path(@resort, start_date: start_date, end_date: end_date, bedrooms: params[:bedrooms], sleeps: params[:sleeps])
    elsif @region
      redirect_to region_property_rent_path(@region)
    # elsif @country
    #   redirect_to
    else
      redirect_to root_path
    end
  end

  def search_sales
    if @resort
      redirect_to resort_property_sale_path(@resort)
    elsif @region
      redirect_to region_property_sale_path(@region)
    else
      redirect_to root_path
    end
  end

  def country_options_for_quick_search
    @countries = if params[:holiday_type_id].blank?
      []
    else
      HolidayType.find(params[:holiday_type_id]).visible_country_brochures.map { |b| b.brochurable }
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
      @resorts = if params[:holiday_type_id].blank?
        country.visible_regions + country.visible_resorts
      else
        country.region_brochures(params[:holiday_type_id]).map { |b| b.brochurable } + country.resort_brochures(params[:holiday_type_id]).map { |b| b.brochurable }
      end
    end
    render layout: false
  end

  def contact
    default_page_title t("contact")
  end

  def privacy
    default_page_title t("privacy")
  end

  def terms
    default_page_title t("terms")
  end

  private

  def set_resort_and_region_from_place_name
    if params[:place_name]
      @resort ||= Resort.find_by(name: params[:place_name])
      @region ||= Region.find_by(name: params[:place_name])
      @country ||= Country.find_by(name: params[:place_name])
    end
  end
end
