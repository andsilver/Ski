class RegionsController < ApplicationController
  def show
    @region = Region.find_by(slug: params[:id])
    if @region
      @featured_properties = @region.featured_properties(9)
    else
      not_found
    end
  end
end
