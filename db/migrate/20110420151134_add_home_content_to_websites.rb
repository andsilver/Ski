class AddHomeContentToWebsites < ActiveRecord::Migration
  def self.up
    add_column :websites, :home_content, :text
  end

  def self.down
    remove_column :websites, :home_content
  end
end
