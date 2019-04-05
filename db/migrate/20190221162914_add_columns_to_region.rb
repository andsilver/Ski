class AddColumnsToRegion < ActiveRecord::Migration[5.2]
  def change
    add_column :regions, :featured, :boolean, default: false
    add_column :regions, :image_url, :string
    add_column :regions, :strapline, :string
  end
end
