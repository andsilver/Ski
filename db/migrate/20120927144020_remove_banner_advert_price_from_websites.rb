class RemoveBannerAdvertPriceFromWebsites < ActiveRecord::Migration
  def up
    remove_column :websites, :banner_advert_price
  end

  def down
    add_column :websites, :banner_advert_price, :integer, default: 0, null: false
  end
end
