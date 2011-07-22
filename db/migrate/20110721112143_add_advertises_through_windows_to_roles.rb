class AddAdvertisesThroughWindowsToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :advertises_through_windows, :boolean, :default => false, :null => false
  end
end
