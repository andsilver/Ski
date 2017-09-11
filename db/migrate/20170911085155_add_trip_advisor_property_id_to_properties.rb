class AddTripAdvisorPropertyIdToProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :trip_advisor_property_id, :integer
    add_index :properties, :trip_advisor_property_id
  end
end
