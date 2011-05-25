class AddInfoToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :info, :text, :default => ''
  end
end
