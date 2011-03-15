class RemoveValidForResortsFromCountries < ActiveRecord::Migration
  def self.up
    remove_index :countries, :valid_for_resorts
    remove_column :countries, :valid_for_resorts
  end

  def self.down
    add_column :countries, :valid_for_resorts, :boolean, :default => false, :null => false
    add_index :countries, :valid_for_resorts
  end
end
