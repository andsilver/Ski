class RegionsController < ApplicationController
  def show
    @region = Region.find_by(slug: params[:id])
  end
end
