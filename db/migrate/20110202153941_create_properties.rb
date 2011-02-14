class CreateProperties < ActiveRecord::Migration
  def self.up
    create_table :properties do |t|
      t.integer :user_id, :null => false
      t.integer :resort_id, :null => false
      t.string :name, :default => '', :null => false
      t.integer :metres_from_lift, :default => 0, :null => false
      t.integer :sleeping_capacity, :default => 0, :null => false
      t.integer :weekly_rent_price, :default => 0, :null => false
      t.integer :number_of_bedrooms, :default => 0, :null => false
      t.integer :image_id

      t.timestamps
    end
    add_index :properties, :resort_id
    add_index :properties, :user_id
  end

  def self.down
    drop_table :properties
  end
end
