class AddResortIdToTripAdvisorLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :trip_advisor_locations, :resort_id, :integer
    add_index :trip_advisor_locations, :resort_id
  end
end
