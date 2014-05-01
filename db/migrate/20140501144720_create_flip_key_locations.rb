class CreateFlipKeyLocations < ActiveRecord::Migration
  def change
    create_table :flip_key_locations do |t|
      t.integer :rgt
      t.string :parent_path, null: false
      t.integer :parent_id
      t.string :display, null: false
      t.integer :lft
      t.integer :property_count, default: 0, null: false

      t.timestamps
    end

    add_index :flip_key_locations, :parent_id
  end
end
