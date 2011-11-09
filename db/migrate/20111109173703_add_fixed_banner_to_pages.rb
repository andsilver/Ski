class AddFixedBannerToPages < ActiveRecord::Migration
  def change
    add_column :pages, :fixed_banner_image_filename, :string, :default => '', :null => false
    add_column :pages, :fixed_banner_target_url, :string, :default => '', :null => false
  end
end
