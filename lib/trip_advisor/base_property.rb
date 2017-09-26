# frozen_string_literal: true

module TripAdvisor
  # Handles construction of the native base Property that will be the container
  # for this TripAdvisorProperty.
  class BaseProperty
    attr_reader :ta_prop

    def initialize(ta_property)
      @ta_prop = ta_property
    end

    def create(currency, user)
      prop = PreparedProperty.new(
        {
          trip_advisor_property_id: ta_prop.id
        }, user
      ).property
      prop.name = ta_prop.title
      prop.resort = ta_prop.resort
      prop.address = 'address'
      prop.currency = currency
      prop.sleeping_capacity = ta_prop.sleeps
      prop.save!
      prop
    end
  end
end
