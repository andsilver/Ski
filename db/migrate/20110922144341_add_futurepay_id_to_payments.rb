class AddFuturepayIdToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :futurepay_id, :string, :default => '', :null => false
  end
end
