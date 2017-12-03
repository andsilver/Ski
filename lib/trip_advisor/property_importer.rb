# frozen_string_literal: true

require_relative '../trip_advisor'

module TripAdvisor
  class PropertyImporter
    attr_reader :json

    def initialize(json)
      @json = json
    end

    def import
      return unless data_valid?

      details = PropertyDetails.new(data)
      details.import

      ta_prop = details.property
      return unless ta_prop.persisted?

      PropertyCalendarImporter.new(ta_prop.id, data['calendar']).import

      prop = BaseProperty.new(ta_prop).create(TripAdvisor.user)
      LongTermAdvert.new(prop).create

      images = PropertyImages.new(prop, json)
      images.import
    end

    private

    def data_valid?
      begin
        data
      rescue
        Rails.logger.warn(
          'Malformed JSON found in TripAdvisor::PropertyImporter'
        )
        false
      end
    end

    def data
      @data ||= JSON.parse(json)
    end
  end
end
