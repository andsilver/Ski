AirportTransferSearch = Struct.new(:airport_id, :resort_id)

class AirportTransfersController < ApplicationController
  before_action :user_required, except: [:find, :results, :skilifts]

  def index
    @airport_transfers = current_user.airport_transfers
  end

  def create
    params[:transfers][:resort_id].each do |resort_id|
      at = AirportTransfer.new
      at.airport_id = params[:transfers][:airport_id]
      at.resort_id = resort_id
      at.user = current_user
      at.save
    end
    redirect_to airport_transfers_path, notice: t("notices.added")
  end

  def destroy
    at = AirportTransfer.find(params[:id])
    if at && at.user == @current_user
      at.destroy
    end
    redirect_to airport_transfers_path, notice: t("notices.deleted")
  end

  def find
    @airport_transfer_search = AirportTransferSearch.new
  end

  def results
    airport_id, resort_id = params[:airport_transfer_search][:airport_id],
                            params[:airport_transfer_search][:resort_id]

    if airport_id.blank? || resort_id.blank?
      redirect_to(action: "find") && return
    end

    @airport = Airport.find(airport_id)
    @resort = Resort.find(resort_id)
    airport_transfers = AirportTransfer.where(airport_id: airport_id, resort_id: resort_id)

    @results = []
    airport_transfers.each do |t|
      ad = t.user.airport_transfer_banner_advert
      @results << ad unless ad.nil?
    end

    @airport_transfer_search = AirportTransferSearch.new(
      params[:airport_transfer_search][:airport_id],
      params[:airport_transfer_search][:resort_id]
    )
  end

  def skilifts
  end
end
