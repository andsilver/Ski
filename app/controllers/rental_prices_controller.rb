RentalPricesSearch = Struct.new(:resort_id, :sleeping_capacity)

class RentalPricesController < ApplicationController
  before_filter :set_heading_and_title

  def index
    @rental_prices_search = RentalPricesSearch.new
  end

  def results
    redirect_to action: 'index' and return unless params[:rental_prices_search].kind_of? Array

    resort_id, sleeping_capacity = params[:rental_prices_search][:resort_id],
      params[:rental_prices_search][:sleeping_capacity]

    unless resort_id.blank? or sleeping_capacity.blank?
      @resort = Resort.find(resort_id)
      @rental_prices_min = Property.where(["resort_id = ? AND sleeping_capacity = ?", resort_id, sleeping_capacity]).minimum('normalised_weekly_rent_price')
      @rental_prices_max = Property.where(["resort_id = ? AND sleeping_capacity = ?", resort_id, sleeping_capacity]).maximum('normalised_weekly_rent_price')
      @rental_prices_avg = Property.where(["resort_id = ? AND sleeping_capacity = ?", resort_id, sleeping_capacity]).average('normalised_weekly_rent_price')
    end

    @rental_prices_search = RentalPricesSearch.new(
      params[:rental_prices_search][:resort_id],
      params[:rental_prices_search][:sleeping_capacity]
    )
    render 'index'
  end

  protected

  def set_heading_and_title
    @heading_a = '<a href="/pages/owner-resources">Owner Resources</a> &gt; Find Rental Prices'.html_safe
    default_page_title('Find Rental Prices')
  end
end
