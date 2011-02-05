class CreateProperties < ActiveRecord::Migration
  def self.up
    create_table :properties do |t|
      t.integer :user_id, :default => 0, :null => false
      t.integer :resort_id, :default => 0, :null => false
      t.string :title, :default => '', :null => false
      t.integer :metres_from_lift, :default => 0, :null => false
      t.integer :sleeps, :default => 0, :null => false
      t.integer :weekly_rent_price, :default => 0, :null => false

      t.timestamps
    end
    add_index :properties, :resort_id
    add_index :properties, :user_id
  end

  def self.down
    drop_table :properties
  end
end
