class SearchController < ApplicationController
  def index
  end

  def place_names
    render json: (Region.pluck('name') + Resort.visible.pluck('name')).sort
  end
end
