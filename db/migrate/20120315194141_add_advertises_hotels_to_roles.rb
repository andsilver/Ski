class AddAdvertisesHotelsToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :advertises_hotels, :boolean, :default => false, :null => false
  end
end
