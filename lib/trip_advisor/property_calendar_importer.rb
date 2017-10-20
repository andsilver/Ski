# frozen_string_literal: true

module TripAdvisor
  class PropertyCalendarImporter
    def initialize(ta_prop_id, calendar)
      @id = ta_prop_id
      @calendar = calendar
    end

    def import
      @calendar.each do |entry|
        TripAdvisorCalendarEntry.create!(
          status: entry['status'],
          inclusive_start: entry['inclusive_start'],
          exclusive_end: entry['exclusive_end'],
          trip_advisor_property_id: @id
        )
      end
    end
  end
end
