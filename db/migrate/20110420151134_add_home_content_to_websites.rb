class AddHomeContentToWebsites < ActiveRecord::Migration
  def self.up
    add_column :websites, :home_content, :text, :default => ''
  end

  def self.down
    remove_column :websites, :home_content
  end
end
