class AddVisibleToRegions < ActiveRecord::Migration
  def change
    add_column :regions, :visible, :boolean, default: true, null: false
    add_index :regions, :visible
  end
end
