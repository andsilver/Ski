# frozen_string_literal: true

class AddIndexOnTripAdvisorPropertyIdToTripAdvisorCalendarEntries < ActiveRecord::Migration[5.1]
  def change
    add_index :trip_advisor_calendar_entries, :trip_advisor_property_id
  end
end
