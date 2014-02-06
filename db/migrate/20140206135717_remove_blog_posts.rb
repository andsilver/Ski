class RemoveBlogPosts < ActiveRecord::Migration
  def up
    drop_table :blog_posts
    remove_column :websites, :blog_visible
  end

  def down
    create_table "blog_posts", force: true do |t|
      t.string   "headline",   default: "",   null: false
      t.text     "content"
      t.integer  "image_id"
      t.datetime "created_at",                null: false
      t.datetime "updated_at",                null: false
      t.boolean  "visible",    default: true, null: false
    end
    
    add_column :websites, :blog_visible, :boolean, default: false, null: false    
  end
end
