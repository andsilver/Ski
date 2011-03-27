class AddPostcodeToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :postcode, :string, :default => '', :null => false
  end

  def self.down
    remove_column :orders, :postcode
  end
end
