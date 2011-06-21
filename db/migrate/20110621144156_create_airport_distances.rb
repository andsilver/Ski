class CreateAirportDistances < ActiveRecord::Migration
  def change
    create_table :airport_distances do |t|
      t.integer :resort_id, :null => false
      t.integer :airport_id, :null => false
      t.integer :distance_km, :default => 0, :null => false
      t.string :comment, :default => '', :null => false

      t.timestamps
    end
    add_index :airport_distances, :resort_id
  end
end
