class InterhomePlaceResortsController < ApplicationController
  before_action :admin_required

  def create
    notice = if InterhomePlaceResort.new(interhome_place_resort_params).save
      t("notices.created")
    else
      "Could not link that Interhome place to this resort."
    end
    redirect_to edit_admin_resort_path(id: Resort.find(params[:interhome_place_resort][:resort_id])), notice: notice
  end

  def destroy
    @interhome_place_resort = InterhomePlaceResort.find(params[:id])
    @interhome_place_resort.destroy
    redirect_to edit_admin_resort_path(id: @interhome_place_resort.resort_id), notice: "Unlinked."
  end

  protected

  def interhome_place_resort_params
    params.require(:interhome_place_resort).permit(:interhome_place_code, :resort_id)
  end
end
