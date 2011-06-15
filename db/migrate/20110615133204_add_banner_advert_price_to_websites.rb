class AddBannerAdvertPriceToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :banner_advert_price, :integer, :default => 0, :null => false
  end
end
