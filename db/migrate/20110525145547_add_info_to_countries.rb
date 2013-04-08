class AddInfoToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :info, :text
  end
end
