class HomeController < ApplicationController
  layout 'application', :except => [:index]

  def index
    @featured_properties = Property.order('RAND()').limit(15).where(publicly_visible: true)
    render layout: "home"
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
