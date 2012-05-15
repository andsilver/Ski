class AddVisibleToBlogPosts < ActiveRecord::Migration
  def change
    add_column :blog_posts, :visible, :boolean, default: true, null: false
  end
end
