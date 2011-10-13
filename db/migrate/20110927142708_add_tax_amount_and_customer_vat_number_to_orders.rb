class AddTaxAmountAndCustomerVatNumberToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :tax_amount, :integer, :default => 0, :null => false
    add_column :orders, :customer_vat_number, :string, :default => '', :null => false
  end
end
