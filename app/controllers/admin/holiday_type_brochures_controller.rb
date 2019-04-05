module Admin
  class HolidayTypeBrochuresController < AdminController
    def create
      brochurable = find_brochurable
      brochure = brochurable.holiday_type_brochures.build(holiday_type_brochure_params)
      brochure.save
      redirect_to(edit_polymorphic_path([:admin, brochurable]), notice: t("notices.created"))
    end

    def destroy
      htb = HolidayTypeBrochure.find(params[:id])
      htb.destroy
      redirect_to edit_polymorphic_path([:admin, htb.brochurable]), notice: t("notices.deleted")
    end

    protected

    def find_brochurable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end

    def holiday_type_brochure_params
      params.require(:holiday_type_brochure).permit(:holiday_type_id)
    end
  end
end
