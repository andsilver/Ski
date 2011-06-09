class AddStartPageContentToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :start_page_content, :text, :default => ''
  end
end
