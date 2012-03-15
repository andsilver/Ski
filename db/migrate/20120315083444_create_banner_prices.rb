class CreateBannerPrices < ActiveRecord::Migration
  def change
    create_table :banner_prices do |t|
      t.integer :current_banner_number, :default => 0, :null => false
      t.integer :price, :default => 0, :null => false

      t.timestamps
    end
  end
end
