class AddNewDevelopmentByDefaultToRoles < ActiveRecord::Migration
  def self.up
    add_column :roles, :new_development_by_default, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :roles, :new_development_by_default
  end
end
