class CountriesController < ApplicationController
  def show
    @country = Country.find(params[:id])
  end
end
