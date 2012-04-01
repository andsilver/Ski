class InterhomePlaceResortsController < ApplicationController
  before_filter :admin_required

  def create
    if InterhomePlaceResort.new(params[:interhome_place_resort]).save
      notice = t('notices.created')
    else
      notice = 'Could not link that Interhome place to this resort.'
    end
    redirect_to edit_resort_path(:id => params[:interhome_place_resort][:resort_id]), :notice => notice
  end

  def destroy
    @interhome_place_resort = InterhomePlaceResort.find(params[:id])
    @interhome_place_resort.destroy
    redirect_to edit_resort_path(:id => @interhome_place_resort.resort_id), :notice => 'Unlinked.'
  end
end
