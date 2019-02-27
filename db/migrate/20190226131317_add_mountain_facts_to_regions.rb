class AddMountainFactsToRegions < ActiveRecord::Migration[5.2]
  def change
    add_column :regions, :altitude_m, :integer
    add_column :regions, :top_lift_m, :integer
    add_column :regions, :piste_length_km, :integer
    add_column :regions, :lifts_n, :integer
    add_column :regions, :green, :integer
    add_column :regions, :blue, :integer
    add_column :regions, :red, :integer
    add_column :regions, :black, :integer
  end
end
