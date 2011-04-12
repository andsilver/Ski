class AddDetailsToResorts < ActiveRecord::Migration
  def self.up
    add_column :resorts, :altitude_m, :integer
    add_column :resorts, :top_lift_m, :integer
    add_column :resorts, :ski_area_km, :integer
    add_column :resorts, :black, :integer
    add_column :resorts, :red, :integer
    add_column :resorts, :blue, :integer
    add_column :resorts, :green, :integer
    add_column :resorts, :longest_run_km, :integer
    add_column :resorts, :drags, :integer
    add_column :resorts, :chair, :integer
    add_column :resorts, :gondola, :integer
    add_column :resorts, :cable_car, :integer
    add_column :resorts, :funicular, :integer
    add_column :resorts, :railways, :integer
    add_column :resorts, :slope_direction, :string
    add_column :resorts, :snowboard_parks, :integer
    add_column :resorts, :cross_country_km, :integer
    add_column :resorts, :mountain_restaurants, :integer
    add_column :resorts, :glacier_skiing, :boolean
    add_column :resorts, :nearest_airport, :string
    add_column :resorts, :distance_from_airport_km, :integer
    add_column :resorts, :lively_apres_ski, :boolean
    add_column :resorts, :good_for_families, :boolean
    add_column :resorts, :creche, :boolean
    add_column :resorts, :babysitting_services, :boolean
  end

  def self.down
    remove_column :resorts, :babysitting_services
    remove_column :resorts, :creche
    remove_column :resorts, :good_for_families
    remove_column :resorts, :lively_apres_ski
    remove_column :resorts, :distance_from_airport_km
    remove_column :resorts, :nearest_airport
    remove_column :resorts, :glacier_skiing
    remove_column :resorts, :mountain_restaurants
    remove_column :resorts, :cross_country_km
    remove_column :resorts, :snowboard_parks
    remove_column :resorts, :slope_direction
    remove_column :resorts, :railways
    remove_column :resorts, :funicular
    remove_column :resorts, :cable_car
    remove_column :resorts, :gondola
    remove_column :resorts, :chair
    remove_column :resorts, :drags
    remove_column :resorts, :longest_run_km
    remove_column :resorts, :green
    remove_column :resorts, :blue
    remove_column :resorts, :red
    remove_column :resorts, :black
    remove_column :resorts, :ski_area_km
    remove_column :resorts, :top_lift_m
    remove_column :resorts, :altitude_m
  end
end
