class AddCurrencyIdToProperties < ActiveRecord::Migration
  def self.up
    add_column :properties, :currency_id, :integer, :default => 1, :null => false
    add_column :properties, :normalised_sale_price, :integer, :default => 0, :null => false
    add_column :properties, :normalised_weekly_rent_price, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :properties, :normalised_weekly_rent_price
    remove_column :properties, :normalised_sale_price
    remove_column :properties, :currency_id
  end
end
