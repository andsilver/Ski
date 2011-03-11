class AddInfoToResorts < ActiveRecord::Migration
  def self.up
    add_column :resorts, :info, :text
  end

  def self.down
    remove_column :resorts, :info
  end
end
