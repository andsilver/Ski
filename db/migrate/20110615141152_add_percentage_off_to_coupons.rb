class AddPercentageOffToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :percentage_off, :integer, :default => 100, :null => false
    rename_column :coupons, :free_adverts, :number_of_adverts
  end
end
