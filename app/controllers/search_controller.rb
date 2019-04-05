class SearchController < ApplicationController
  def index
  end

  def place_names
    render json: (
        Country.pluck("name", "property_count") +
        Region.pluck("name", "property_count") +
        Resort.visible.pluck("name", "property_count")
      )
      .sort
      .map {|x| {name: x[0], count: x[1]} }
  end
end
