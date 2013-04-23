class AirportDistancesController < ApplicationController
  before_filter :admin_required
  before_filter :find_airport_distance, only: [:edit, :update, :destroy]
  before_filter :no_browse_menu

  def index
    @airport_distances = AirportDistance.all
  end

  def new
    @airport_distance = AirportDistance.new
  end

  def create
    @airport_distance = AirportDistance.new(airport_distance_params)

    if @airport_distance.save
      redirect_to(airport_distances_path, notice: t('notices.created'))
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @airport_distance.update_attributes(airport_distance_params)
      redirect_to(airport_distances_path, notice: t('notices.saved'))
    else
      render "edit"
    end
  end

  def destroy
    @airport_distance.destroy
    redirect_to airport_distances_path, notice: t('notices.deleted')
  end

  protected

  def find_airport_distance
    @airport_distance = AirportDistance.find(params[:id])
  end

  def airport_distance_params
    params.require(:airport_distance).permit(:airport_id, :distance_km, :resort_id)
  end
end
