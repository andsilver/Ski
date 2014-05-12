class Admin::FlipKeyLocationsController < ApplicationController
  before_action :admin_required
  before_action :set_flip_key_location, only: [:show, :update]

  layout 'admin'

  def index
    @flip_key_locations = FlipKeyLocation.where(parent_id: nil)
  end

  def show
  end

  def update
    @flip_key_location.cascade_resort_id= params[:flip_key_location][:resort_id]
    redirect_to [:admin, @flip_key_location], notice: 'Updated.'
  end

  private

    def set_flip_key_location
      @flip_key_location = FlipKeyLocation.find(params[:id])
    end
end
