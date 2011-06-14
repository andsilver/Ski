class HomeController < ApplicationController
  layout 'application', :except => [:index]

  def index
    render :layout => "home"
  end

  def privacy
    default_page_title t('privacy')
  end

  def start
    default_page_title t('start')
    @stage_heading_a = I18n.t('stage_1')
  end

  def terms
    default_page_title t('terms')
  end
end
