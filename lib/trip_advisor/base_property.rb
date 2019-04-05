# frozen_string_literal: true

module TripAdvisor
  # Handles construction of the native base Property that will be the container
  # for this TripAdvisorProperty.
  class BaseProperty
    attr_reader :ta_prop

    def initialize(ta_property)
      @ta_prop = ta_property
    end

    def create(user)
      prop = PreparedProperty.new(
        {
          trip_advisor_property_id: ta_prop.id,
        }, user
      ).property
      prop.name = ta_prop.title
      prop.strapline = prop.description = ta_prop.description
      prop.tidy_name_and_strapline
      prop.resort = ta_prop.resort
      prop.address = "address"
      prop.currency = ta_prop.currency
      prop.weekly_rent_price = ta_prop.starting_price * 7
      prop.number_of_bedrooms = ta_prop.bedrooms
      prop.sleeping_capacity = ta_prop.sleeps
      prop.number_of_bathrooms = ta_prop.bathrooms
      prop.save!
      prop
    end
  end
end
