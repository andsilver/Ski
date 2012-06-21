class AirportTransfersController < ApplicationController
  before_filter :user_required

  def index
    default_page_title(@heading_a = t('airport_transfers_controller.titles.index'))
    @airport_transfers = @current_user.airport_transfers
  end

  def create
    params[:transfers][:resort_id].each do |resort_id|
      at = AirportTransfer.new
      at.airport_id = params[:transfers][:airport_id]
      at.resort_id = resort_id
      at.user = @current_user
      at.save
    end
    redirect_to airport_transfers_path, notice: t('notices.added')
  end

  def destroy
    at = AirportTransfer.find(params[:id])
    if at && at.user == @current_user
      at.destroy
    end
    redirect_to airport_transfers_path, notice: t('notices.deleted')
  end
end
