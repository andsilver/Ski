class PvAccommodationsController < ApplicationController
  before_filter :admin_required

  def index
    @pv_accommodations = PvAccommodation.all
  end
end
