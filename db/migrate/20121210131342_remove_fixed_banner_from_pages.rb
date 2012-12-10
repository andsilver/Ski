class RemoveFixedBannerFromPages < ActiveRecord::Migration
  def up
    remove_column :pages, :fixed_banner_image_filename
    remove_column :pages, :fixed_banner_target_url
  end

  def down
    add_column :pages, :fixed_banner_image_filename, :string, :default => '', :null => false
    add_column :pages, :fixed_banner_target_url, :string, :default => '', :null => false
  end
end
