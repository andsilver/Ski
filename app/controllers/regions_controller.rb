class RegionsController < ApplicationController
  before_action :set_resort

  def show; end

  def how_to_get_there; end

  private

    def set_resort
      @region = Region.find_by(slug: params[:id])
      if @region
        @featured_properties = @region.featured_properties(9)
      else
        not_found
      end
    end
end
