class PvPlaceResortsController < ApplicationController
  before_filter :admin_required

  def create
    if PvPlaceResort.new(params[:pv_place_resort]).save
      notice = t('notices.created')
    else
      notice = 'Could not link that P&V place to this resort.'
    end
    redirect_to edit_resort_path(id: params[:pv_place_resort][:resort_id]), notice: notice
  end

  def destroy
    @pv_place_resort = PvPlaceResort.find(params[:id])
    @pv_place_resort.destroy
    redirect_to edit_resort_path(id: @pv_place_resort.resort_id), notice: 'Unlinked.'
  end
end
