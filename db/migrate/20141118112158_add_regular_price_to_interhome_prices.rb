class AddRegularPriceToInterhomePrices < ActiveRecord::Migration
  def change
    add_column :interhome_prices, :regular_price, :integer, default: 0, null: false
  end
end
