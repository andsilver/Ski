class AddPayMonthlyToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :pay_monthly, :boolean, :default => false, :null => :false
    add_column :orders, :first_payment, :integer, :default => 0, :null => :false
    add_column :orders, :subsequent_payments, :integer, :default => 0, :null => :false
  end
end
