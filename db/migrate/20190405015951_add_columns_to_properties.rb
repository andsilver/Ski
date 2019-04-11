class AddColumnsToProperties < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :video, :string
    add_column :properties, :energy_performance, :string
    add_column :properties, :floorplan, :string
  end
end
