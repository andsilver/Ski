class AddVatNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :vat_number, :string, :default => '', :null => false
  end
end
