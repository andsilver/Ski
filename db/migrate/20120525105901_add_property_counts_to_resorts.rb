class AddPropertyCountsToResorts < ActiveRecord::Migration
  def change
    add_column :resorts, :property_count, :integer, default: 0, null: false
    add_column :resorts, :for_rent_count, :integer, default: 0, null: false
    add_column :resorts, :for_sale_count, :integer, default: 0, null: false
    add_column :resorts, :hotel_count, :integer, default: 0, null: false
    add_column :resorts, :new_development_count, :integer, default: 0, null: false
  end
end
