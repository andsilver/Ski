class AddCouponIdAndCountryIdAndResortIdToOrderLines < ActiveRecord::Migration
  def self.up
    add_column :order_lines, :coupon_id, :integer
    add_column :order_lines, :country_id, :integer
    add_column :order_lines, :resort_id, :integer
    add_index :order_lines, :coupon_id
    add_index :order_lines, :country_id
    add_index :order_lines, :resort_id
  end

  def self.down
    remove_column :order_lines, :coupon_id
    remove_column :order_lines, :country_id
    remove_column :order_lines, :resort_id
  end
end
