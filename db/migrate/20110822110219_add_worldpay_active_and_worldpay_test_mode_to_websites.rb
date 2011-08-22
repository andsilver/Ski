class AddWorldpayActiveAndWorldpayTestModeToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :worldpay_active, :boolean, :default => false, :null => false
    add_column :websites, :worldpay_test_mode, :boolean, :default => false, :null => false
  end
end
