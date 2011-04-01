class AddPropertyIdToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :property_id, :integer
    add_index :images, :property_id
  end

  def self.down
    remove_column :images, :property_id
  end
end
