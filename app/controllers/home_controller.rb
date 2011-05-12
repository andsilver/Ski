class HomeController < ApplicationController
  layout 'application', :except => [:index]
  def index
    render :layout => "home"
  end
end
