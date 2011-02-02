class CountriesController < ApplicationController
  def show
    @browse_country = @country = Country.find(params[:id])
  end
end
