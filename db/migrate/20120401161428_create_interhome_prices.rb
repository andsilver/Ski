class CreateInterhomePrices < ActiveRecord::Migration
  def change
    create_table :interhome_prices do |t|
      t.string :accommodation_code, :null => false
      t.integer :days, :null => false
      t.date :start_date, :null => false
      t.date :end_date, :null => false
      t.integer :rental_price, :null => false
      t.integer :min_rental_price, :null => false
      t.integer :max_rental_price, :null => false
      t.string :special_offer_code
      t.integer :special_offer_price

      t.timestamps
    end

    add_index :interhome_prices, :accommodation_code
  end
end
