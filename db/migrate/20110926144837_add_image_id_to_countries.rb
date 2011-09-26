class AddImageIdToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :image_id, :integer
  end
end
