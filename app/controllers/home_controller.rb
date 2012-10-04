class HomeController < ApplicationController
  layout 'application', except: [:index]

  def index
    @featured_properties = @w.featured_properties
    render layout: 'home'
  end

  def resort_options_for_quick_search
    if params[:country_id].blank?
      @resorts = []
    else
      @resorts = Country.find(params[:country_id]).visible_resorts
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
