class AddResourcesBannerHtmlToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :resources_banner_html, :text
  end
end
