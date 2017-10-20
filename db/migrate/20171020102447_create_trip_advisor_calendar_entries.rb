# frozen_string_literal: true

class CreateTripAdvisorCalendarEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :trip_advisor_calendar_entries do |t|
      t.integer :trip_advisor_property_id
      t.string :status, null: false
      t.date :inclusive_start, null: false
      t.date :exclusive_end, null: false

      t.timestamps
    end
  end
end
