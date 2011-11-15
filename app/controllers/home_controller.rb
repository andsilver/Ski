class HomeController < ApplicationController
  layout 'application', :except => [:index]

  def index
    render :layout => "home"
  end

  def contact
    default_page_title t('contact')
  end

  def links
    default_page_title t('links')
  end

  def privacy
    default_page_title t('privacy')
  end

  def terms
    default_page_title t('terms')
  end
end
