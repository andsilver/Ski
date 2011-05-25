class HomeController < ApplicationController
  layout 'application', :except => [:index]

  def index
    render :layout => "home"
  end

  def start
    @stage_heading_a = I18n.t('stage_1')
  end
end
