class LateAvailabilityController < ApplicationController
  def index
    @featured_properties = LateAvailability::Finder.new.find_featured(limit: 9)
  end
end
