class AddHasAWebsiteToRoles < ActiveRecord::Migration
  def self.up
    add_column :roles, :has_a_website, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :roles, :has_a_website
  end
end
