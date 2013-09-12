class PvPlaceResortsController < ApplicationController
  before_action :admin_required

  def create
    if PvPlaceResort.new(pv_place_resort_params).save
      notice = t('notices.created')
    else
      notice = 'Could not link that P&V place to this resort.'
    end
    redirect_to edit_admin_resort_path(id: params[:pv_place_resort][:resort_id]), notice: notice
  end

  def destroy
    @pv_place_resort = PvPlaceResort.find(params[:id])
    @pv_place_resort.destroy
    redirect_to edit_admin_resort_path(id: @pv_place_resort.resort_id), notice: 'Unlinked.'
  end

  protected

  def pv_place_resort_params
    params.require(:pv_place_resort).permit(:pv_place_code, :resort_id)
  end
end
