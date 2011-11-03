class AddExpiresOnToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :expires_on, :date
  end
end
