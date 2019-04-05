# frozen_string_literal: true

module TripAdvisor
  class PropertyCalendarImporter
    def initialize(ta_prop, calendar)
      @ta_prop = ta_prop
      @calendar = calendar
    end

    def import
      @ta_prop.clear_calendar
      @calendar.each do |entry|
        TripAdvisorCalendarEntry.create!(
          status: entry["status"],
          inclusive_start: entry["inclusive_start"],
          exclusive_end: entry["exclusive_end"],
          trip_advisor_property: @ta_prop
        )
      end
    end
  end
end
