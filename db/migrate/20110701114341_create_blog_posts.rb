class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :headline, :default => '', :null => false
      t.text :content
      t.integer :image_id

      t.timestamps
    end
  end
end
