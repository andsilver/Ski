class AddVisibleToResorts < ActiveRecord::Migration
  def self.up
    add_column :resorts, :visible, :boolean, :default => false, :null => false
    add_index :resorts, :visible
  end

  def self.down
    remove_column :resorts, :visible
  end
end
