module Admin
  class HolidayTypesController < AdminController
    before_action :set_holiday_type, only: [:edit, :update, :destroy]

    def index
      @holiday_types = HolidayType.order("name")
    end

    def new
      @holiday_type = HolidayType.new
    end

    def create
      @holiday_type = HolidayType.new(holiday_type_params)

      if @holiday_type.save
        redirect_to(admin_holiday_types_path, notice: t("notices.created"))
      else
        render "new"
      end
    end

    def edit
    end

    def update
      if @holiday_type.update_attributes(holiday_type_params)
        redirect_to(admin_holiday_types_path, notice: t("notices.saved"))
      else
        render "edit"
      end
    end

    def destroy
      @holiday_type.destroy
      redirect_to admin_holiday_types_path, notice: t("notices.deleted")
    end

    protected

    def set_holiday_type
      @holiday_type = HolidayType.find_by(slug: params[:id])
    end

    def holiday_type_params
      params.require(:holiday_type).permit(:mega_menu_html, :name, :sidebar_html, :slug, :visible_on_menu)
    end
  end
end
