class CreatePropertyBasePrices < ActiveRecord::Migration
  def self.up
    create_table :property_base_prices do |t|
      t.integer :number_of_months, :default => 0, :null => false
      t.integer :price, :default => 0, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :property_base_prices
  end
end
