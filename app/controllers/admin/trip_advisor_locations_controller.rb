module Admin
  class TripAdvisorLocationsController < AdminController
    before_action :set_location, only: [:show, :update]

    def index
      @locations = TripAdvisorLocation.where(parent_id: nil)
    end

    def show
    end

    def update
      @location.cascade_resort_id = params[:trip_advisor_location][:resort_id]
      redirect_to [:admin, @location], notice: "Updated."
    end

    private

    def set_location
      @location = TripAdvisorLocation.find(params[:id])
    end
  end
end
