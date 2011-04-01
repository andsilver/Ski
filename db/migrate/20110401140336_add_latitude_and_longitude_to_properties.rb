class AddLatitudeAndLongitudeToProperties < ActiveRecord::Migration
  def self.up
    add_column :properties, :latitude, :string, :default => '', :null => false
    add_column :properties, :longitude, :string, :default => '', :null => false
  end

  def self.down
    remove_column :properties, :longitude
    remove_column :properties, :latitude
  end
end
