class AddPriceOverrideToUsers < ActiveRecord::Migration
  def change
    add_column :users, :apply_price_override, :boolean, default: false, null: false
    add_column :users, :price_override, :integer, default: 0, null: false
  end
end
