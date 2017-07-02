module Admin
  class TripAdvisorLocationsController < AdminController
    before_action :set_location, only: [:show]

    def index
      @locations = TripAdvisorLocation.where(parent_id: nil)
    end

    def show
    end

    private

    def set_location
      @location = TripAdvisorLocation.find(params[:id])
    end
  end
end
