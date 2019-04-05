class AddPricePerNightToProperties < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :price_per_night, :float, default: 0, null: false
  end
end
