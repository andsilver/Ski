class AddRegionIdToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :region_id, :integer
  end
end
