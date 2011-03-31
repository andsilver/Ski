class AddDescriptionToProperties < ActiveRecord::Migration
  def self.up
    add_column :properties, :description, :text, :default => ''
  end

  def self.down
    remove_column :properties, :description
  end
end
