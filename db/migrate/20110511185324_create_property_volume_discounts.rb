class CreatePropertyVolumeDiscounts < ActiveRecord::Migration
  def self.up
    create_table :property_volume_discounts do |t|
      t.integer :current_property_number, :default => 0, :null => false
      t.integer :discount_percentage, :default => 0, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :property_volume_discounts
  end
end
