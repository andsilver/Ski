class AddAdvertisesPropertiesToRoles < ActiveRecord::Migration
  def change
    rename_column :roles, :advertises_properties, :advertises_properties_for_rent
    add_column :roles, :advertises_properties_for_sale, :boolean, :default => false, :null => false
  end
end
