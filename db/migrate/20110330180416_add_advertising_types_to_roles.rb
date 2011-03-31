class AddAdvertisingTypesToRoles < ActiveRecord::Migration
  def self.up
    add_column :roles, :advertises_properties, :boolean, :default => false, :null => false
    add_column :roles, :advertises_generally, :boolean, :default => false, :null => false
    add_column :roles, :has_business_details, :boolean, :default => false, :null => false
    remove_column :users, :interested_in_renting_out_properties
  end

  def self.down
    add_column :users, :interested_in_renting_out_properties, :boolean, :default => false, :null => false
    remove_column :roles, :has_business_details
    remove_column :roles, :advertises_generally
    remove_column :roles, :advertises_properties
  end
end
