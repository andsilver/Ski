class Admin::ResortHolidayTypesController < ApplicationController
  def create
    rht = ResortHolidayType.create(resort_holiday_type_params)
    redirect_to(edit_admin_resort_path(rht.resort), notice: t('notices.created'))
  end

  def destroy
    rht = ResortHolidayType.find(params[:id])
    rht.destroy
    redirect_to edit_admin_resort_path(rht.resort), notice: t('notices.deleted')
  end

  protected

    def resort_holiday_type_params
      params.require(:resort_holiday_type).permit(:holiday_type_id, :resort_id)
    end
end
