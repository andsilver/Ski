class AddSidebarHtmlToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :sidebar_html, :text
  end
end
