class AddDescriptionToProperties < ActiveRecord::Migration
  def self.up
    add_column :properties, :description, :text
  end

  def self.down
    remove_column :properties, :description
  end
end
