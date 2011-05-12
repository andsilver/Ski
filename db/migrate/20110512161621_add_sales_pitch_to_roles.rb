class AddSalesPitchToRoles < ActiveRecord::Migration
  def self.up
    add_column :roles, :sales_pitch, :text, :default => ''
  end

  def self.down
    remove_column :roles, :sales_pitch
  end
end
