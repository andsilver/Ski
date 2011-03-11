class CreateProperties < ActiveRecord::Migration
  def self.up
    create_table :properties do |t|
      t.integer :user_id, :null => false
      t.integer :resort_id, :null => false
      t.string :name, :default => '', :null => false
      t.string :strapline, :default => '', :null => false
      t.integer :metres_from_lift, :default => 0, :null => false
      t.integer :sleeping_capacity, :default => 0, :null => false
      t.integer :number_of_bedrooms, :default => 0, :null => false

      t.boolean :new_development, :default => false, :null => false

      t.boolean :for_sale, :default => false, :null => false

      t.integer :image_id

      # rent only
      t.integer :weekly_rent_price, :default => 0, :null => false

      t.boolean :fully_equipped_kitchen, :default => false, :null => false
      t.boolean :tv, :default => false, :null => false
      t.boolean :wifi, :default => false, :null => false
      t.boolean :disabled, :default => false, :null => false
      t.boolean :parking, :default => false, :null => false
      t.boolean :pets, :default => false, :null => false
      t.boolean :smoking, :default => false, :null => false

      # sale only
      t.integer :sale_price, :default => 0, :null => false
      t.boolean :garage, :default => false, :null => false
      t.boolean :private_garden, :default => false, :null => false
      t.integer :floor_area_metres_2, :default => 0, :null => false
      t.integer :plot_size_metres_2, :default => 0, :null => false

      t.timestamps
    end
    add_index :properties, :resort_id
    add_index :properties, :user_id
  end

  def self.down
    drop_table :properties
  end
end
