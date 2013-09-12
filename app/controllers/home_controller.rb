class HomeController < ApplicationController
  def index
    @featured_properties = @w.featured_properties
  end

  def country_options_for_quick_search
    if params[:holiday_type_id].blank?
      @countries = []
    else
      @countries = HolidayType.find(params[:holiday_type_id]).visible_country_brochures.map { |b| b.brochurable }
    end
    render layout: false
  end

  def resort_options_for_quick_search
    if params[:country_id].blank?
      @resorts = []
    else
      country = Country.find(params[:country_id])
      if params[:holiday_type_id].blank?
        @resorts = country.visible_resorts
      else
        @resorts = country.resort_brochures(params[:holiday_type_id]).map { |b| b.brochurable }
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
end
