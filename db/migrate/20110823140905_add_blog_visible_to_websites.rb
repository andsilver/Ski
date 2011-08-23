class AddBlogVisibleToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :blog_visible, :boolean, :default => false, :null => false
  end
end
