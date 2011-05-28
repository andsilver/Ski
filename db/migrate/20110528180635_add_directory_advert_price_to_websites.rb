class AddDirectoryAdvertPriceToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :directory_advert_price, :integer, :default => 0, :null => false
  end
end
