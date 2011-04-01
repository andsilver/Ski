class AddAddressToProperties < ActiveRecord::Migration
  def self.up
    add_column :properties, :address, :string, :default => '', :null => false
    add_column :properties, :postcode, :string, :default => '', :null => false
  end

  def self.down
    remove_column :properties, :postcode
    remove_column :properties, :address
  end
end
