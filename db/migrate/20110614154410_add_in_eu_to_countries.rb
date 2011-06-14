class AddInEuToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :in_eu, :boolean, :default => false, :null => false
  end
end
