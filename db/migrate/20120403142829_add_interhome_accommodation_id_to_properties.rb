class AddInterhomeAccommodationIdToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :interhome_accommodation_id, :integer
    add_index :properties, :interhome_accommodation_id
  end
end
