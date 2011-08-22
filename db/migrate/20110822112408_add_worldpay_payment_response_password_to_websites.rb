class AddWorldpayPaymentResponsePasswordToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :worldpay_payment_response_password, :string, :default => "", :null => false
  end
end
