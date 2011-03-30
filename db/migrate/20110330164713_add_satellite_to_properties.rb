class AddSatelliteToProperties < ActiveRecord::Migration
  def self.up
    add_column :properties, :satellite, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :properties, :satellite
  end
end
