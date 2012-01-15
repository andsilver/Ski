class AddBannerDetailsToDirectoryAdverts < ActiveRecord::Migration
  def change
    add_column :directory_adverts, :description, :text
    add_column :directory_adverts, :is_banner_advert, :boolean, :default => false, :null => false
    add_column :directory_adverts, :banner_image_id, :integer
    add_column :directory_adverts, :width, :integer, :default => 0, :null => false
    add_column :directory_adverts, :height, :integer, :default => 0, :null => false
    add_column :directory_adverts, :clicks, :integer, :default => 0, :null => false
  end
end
