class Admin::FlipKeyLocationsController < ApplicationController
  before_action :admin_required

  layout 'admin'

  def index
    @flip_key_locations = FlipKeyLocation.where(parent_id: nil)
  end

  def show
    @flip_key_location = FlipKeyLocation.find(params[:id])
  end
end
