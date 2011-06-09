class AddPopularBillingCountryToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :popular_billing_country, :boolean, :default => false, :null => false
  end
end
