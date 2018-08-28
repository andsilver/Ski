# frozen_string_literal: true

class AddIndexOnUpdatedAtToTripAdvisorProperties < ActiveRecord::Migration[5.1]
  def change
    add_index :trip_advisor_properties, :updated_at
  end
end
