class AirportsController < ApplicationController
  before_filter :admin_required
  before_filter :find_airport, :only => [:edit, :update, :destroy]
  before_filter :no_browse_menu

  def index
    @airports = Airport.all(:order => 'code')
  end

  def new
    @airport = Airport.new
  end

  def create
    @airport = Airport.new(params[:airport])

    if @airport.save
      redirect_to(airports_path, :notice => t('notices.created'))
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @airport.update_attributes(params[:airport])
      redirect_to(airports_path, :notice => t('notices.saved'))
    else
      render "edit"
    end
  end

  def destroy
    @airport.destroy
    redirect_to airports_path, :notice => t('notices.deleted')
  end

  protected

  def find_airport
    @airport = Airport.find(params[:id])
  end
end
