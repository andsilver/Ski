class AddCountryIdAndPubliclyVisibleToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :country_id, :integer
    add_column :properties, :publicly_visible, :boolean, default: false, null: false
    add_index :properties, :country_id
    add_index :properties, :publicly_visible
  end
end
