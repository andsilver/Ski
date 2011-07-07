class RemoveDistanceFromAirportKmFromResorts < ActiveRecord::Migration
  def up
    remove_column :resorts, :distance_from_airport_km
  end

  def down
    add_column :resorts, :distance_from_airport_km, :integer
  end
end
