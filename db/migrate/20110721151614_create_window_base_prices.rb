class CreateWindowBasePrices < ActiveRecord::Migration
  def change
    create_table :window_base_prices do |t|
      t.integer :quantity, :default => 0, :null => false
      t.integer :price, :default => 0, :null => false

      t.timestamps
    end
  end
end
