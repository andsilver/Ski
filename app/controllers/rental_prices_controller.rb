RentalPricesSearch = Struct.new(:resort_id, :sleeping_capacity)

class RentalPricesController < ApplicationController
  before_action :set_heading_and_title

  def index
    @rental_prices_search = RentalPricesSearch.new
  end

  def results
    redirect_to(action: "index") && return unless params[:rental_prices_search].is_a? Hash

    resort_id, sleeping_capacity = params[:rental_prices_search][:resort_id],
                                   params[:rental_prices_search][:sleeping_capacity]

    unless resort_id.blank? || sleeping_capacity.blank?
      @found_resort = Resort.find(resort_id)
      @rental_prices_min = Property.where(["resort_id = ? AND sleeping_capacity = ?", resort_id, sleeping_capacity]).minimum("normalised_weekly_rent_price")
      @rental_prices_max = Property.where(["resort_id = ? AND sleeping_capacity = ?", resort_id, sleeping_capacity]).maximum("normalised_weekly_rent_price")
      @rental_prices_avg = Property.where(["resort_id = ? AND sleeping_capacity = ?", resort_id, sleeping_capacity]).average("normalised_weekly_rent_price")
    end

    @rental_prices_search = RentalPricesSearch.new(
      params[:rental_prices_search][:resort_id],
      params[:rental_prices_search][:sleeping_capacity]
    )
    render "index"
  end

  protected

  def set_heading_and_title
    default_page_title("Find Rental Prices")
  end
end
