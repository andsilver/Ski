class AddPropertyCountToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :property_count, :integer, default: 0, null: false
  end
end
