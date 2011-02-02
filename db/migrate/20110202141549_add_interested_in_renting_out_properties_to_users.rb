class AddInterestedInRentingOutPropertiesToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :interested_in_renting_out_properties, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :users, :interested_in_renting_out_properties
  end
end
