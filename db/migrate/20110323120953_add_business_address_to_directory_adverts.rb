class AddBusinessAddressToDirectoryAdverts < ActiveRecord::Migration
  def self.up
    add_column :directory_adverts, :business_address, :string, :null => false
    add_column :directory_adverts, :postcode, :string, :default => '', :null => false
  end

  def self.down
    remove_column :directory_adverts, :postcode
    remove_column :directory_adverts, :business_address
  end
end
