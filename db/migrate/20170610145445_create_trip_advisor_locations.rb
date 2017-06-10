class CreateTripAdvisorLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :trip_advisor_locations do |t|
      t.string :name, null: false
      t.string :location_type, null: false
      t.integer :parent_id

      t.timestamps
    end

    add_index :trip_advisor_locations, :parent_id
  end
end
