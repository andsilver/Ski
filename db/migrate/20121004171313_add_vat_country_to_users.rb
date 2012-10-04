class AddVatCountryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :vat_country_id, :integer
  end
end
