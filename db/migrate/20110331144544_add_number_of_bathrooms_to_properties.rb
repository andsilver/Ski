class AddNumberOfBathroomsToProperties < ActiveRecord::Migration
  def self.up
    add_column :properties, :number_of_bathrooms, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :properties, :number_of_bathrooms
  end
end
