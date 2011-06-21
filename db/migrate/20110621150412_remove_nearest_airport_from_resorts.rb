class RemoveNearestAirportFromResorts < ActiveRecord::Migration
  def up
    remove_column :resorts, :nearest_airport
  end

  def down
    add_column :resorts, :nearest_airport, :string
  end
end
