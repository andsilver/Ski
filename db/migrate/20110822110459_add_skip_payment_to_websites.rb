class AddSkipPaymentToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :skip_payment, :boolean, :default => false, :null => false
  end
end
