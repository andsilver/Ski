class SeparatePisteLengthAndSkiArea < ActiveRecord::Migration
  def change
    rename_column :resorts, :ski_area_km, :piste_length_km
    add_column :resorts, :ski_area_acre, :integer
  end
end
