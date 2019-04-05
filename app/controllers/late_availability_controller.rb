class LateAvailabilityController < ApplicationController
  def index
    @featured_properties = LateAvailability::Finder.new.find_featured(limit: 8)
    default_page_title t("late_availability_controller.titles.index")
  end
end
