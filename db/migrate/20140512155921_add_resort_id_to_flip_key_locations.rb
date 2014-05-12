class AddResortIdToFlipKeyLocations < ActiveRecord::Migration
  def change
    add_column :flip_key_locations, :resort_id, :integer
    add_index :flip_key_locations, :resort_id
  end
end
