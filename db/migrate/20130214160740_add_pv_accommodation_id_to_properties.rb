class AddPvAccommodationIdToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :pv_accommodation_id, :integer
    add_index :properties, :pv_accommodation_id
  end
end
