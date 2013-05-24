class AddRegionIdToResorts < ActiveRecord::Migration
  def change
    add_column :resorts, :region_id, :integer
    add_index :resorts, :region_id
  end
end
