module Admin
  class AirportsController < AdminController
    before_action :set_airport, only: [:edit, :update, :destroy]

    def index
      @airports = Airport.order("code")
    end

    def new
      @airport = Airport.new
    end

    def create
      @airport = Airport.new(airport_params)

      if @airport.save
        redirect_to(admin_airports_path, notice: t("notices.created"))
      else
        render "new"
      end
    end

    def edit
    end

    def update
      if @airport.update_attributes(airport_params)
        redirect_to(admin_airports_path, notice: t("notices.saved"))
      else
        render "edit"
      end
    end

    def destroy
      @airport.destroy
      redirect_to admin_airports_path, notice: t("notices.deleted")
    end

    protected

    def set_airport
      @airport = Airport.find(params[:id])
    end

    def airport_params
      params.require(:airport).permit(:code, :country_id, :name)
    end
  end
end
