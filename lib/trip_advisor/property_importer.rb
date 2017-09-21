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

      prop = BaseProperty.new(ta_prop).create(Currency.euro, TripAdvisor.user)
      LongTermAdvert.new(prop).create
    end
  end
end
