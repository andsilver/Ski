class AddDiscountAmountToPropertyVolumeDiscounts < ActiveRecord::Migration
  def change
    add_column :property_volume_discounts, :discount_amount, :integer, :default => 0, :null => false
  end
end
