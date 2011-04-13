class AddFacilitiesToProperties < ActiveRecord::Migration
  def self.up
    add_column :properties, :balcony, :boolean, :default => false, :null => false
    add_column :properties, :mountain_views, :boolean, :default => false, :null => false
    add_column :properties, :log_fire, :boolean, :default => false, :null => false
    add_column :properties, :cave, :boolean, :default => false, :null => false
    add_column :properties, :ski_in_ski_out, :boolean, :default => false, :null => false
    add_column :properties, :hot_tub, :boolean, :default => false, :null => false
    add_column :properties, :indoor_swimming_pool, :boolean, :default => false, :null => false
    add_column :properties, :outdoor_swimming_pool, :boolean, :default => false, :null => false
    add_column :properties, :sauna, :boolean, :default => false, :null => false
    add_column :properties, :distance_from_town_centre_m, :integer, :default => 0, :null => false
    change_column :properties, :tv, :integer, :default => 0, :null => false
    remove_column :properties, :satellite
    change_column :properties, :parking, :integer, :default => 0, :null => false
    remove_column :properties, :garage
    rename_column :properties, :private_garden, :garden
    add_column :properties,:accommodation_type, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :properties, :accommodation_type
    rename_column :properties, :garden, :private_garden
    add_column :properties, :garage, :boolean, :default => false, :null => false
    change_column :properties, :parking, :boolean, :default => false, :null => false
    add_column :properties, :satellite, :boolean, :default => false, :null => false
    change_column :properties, :tv, :boolean, :default => false, :null => false
    remove_column :properties, :distance_from_town_centre_m
    remove_column :properties, :sauna
    remove_column :properties, :outdoor_swimming_pool
    remove_column :properties, :indoor_swimming_pool
    remove_column :properties, :hot_tub
    remove_column :properties, :ski_in_ski_out
    remove_column :properties, :cave
    remove_column :properties, :log_fire
    remove_column :properties, :mountain_views
    remove_column :properties, :balcony
  end
end
