class AddWorldpayInstallationIdToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :worldpay_installation_id, :string, :default => '', :null => false
  end
end
