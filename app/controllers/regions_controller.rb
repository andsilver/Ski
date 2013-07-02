class RegionsController < ApplicationController
  def show
    @region = Region.find_by(slug: params[:id])
    not_found unless @region
  end
end
