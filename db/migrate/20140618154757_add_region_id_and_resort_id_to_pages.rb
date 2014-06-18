class AddRegionIdAndResortIdToPages < ActiveRecord::Migration
  def change
    add_column :pages, :region_id, :integer
    add_column :pages, :resort_id, :integer
    add_index :pages, :region_id
    add_index :pages, :resort_id
  end
end
