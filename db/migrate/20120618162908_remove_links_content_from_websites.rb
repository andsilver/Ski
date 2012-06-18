class RemoveLinksContentFromWebsites < ActiveRecord::Migration
  def up
    remove_column :websites, :links_content
  end

  def down
    add_column :websites, :links_content, :text
  end
end
