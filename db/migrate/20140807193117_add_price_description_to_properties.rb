class AddPriceDescriptionToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :price_description, :string, default: '', null: false
  end
end
