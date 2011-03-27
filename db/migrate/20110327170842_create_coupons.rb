class CreateCoupons < ActiveRecord::Migration
  def self.up
    create_table :coupons do |t|
      t.string :code
      t.integer :free_adverts

      t.timestamps
    end
    add_column :users, :coupon_id, :integer
  end

  def self.down
    remove_column :users, :coupon_id
    drop_table :coupons
  end
end
