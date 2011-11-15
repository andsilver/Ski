class AddLinksContentToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :links_content, :text
  end
end
