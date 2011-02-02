class AddResortIdToProperties < ActiveRecord::Migration
  def self.up
    add_column :properties, :resort_id, :integer, :default => 0, :null => false
    add_index :properties, :resort_id
  end

  def self.down
    remove_index :properties, :resort_id
    remove_column :properties, :resort_id
  end
end
