# frozen_string_literal: true

require_relative '../trip_advisor'

module TripAdvisor
  class PropertyImporter
    attr_reader :json

    def initialize(json)
      @json = json
    end

    def import
      details = PropertyDetails.new(json)
      details.import

      ta_prop = details.property
      return unless ta_prop.persisted?

      prop = BaseProperty.new(ta_prop).create(TripAdvisor.user)
      LongTermAdvert.new(prop).create

      images = PropertyImages.new(prop, json)
      images.import
    end
  end
end
