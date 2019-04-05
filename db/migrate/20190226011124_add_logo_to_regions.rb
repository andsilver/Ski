class AddLogoToRegions < ActiveRecord::Migration[5.2]
  def change
    add_column :regions, :logo_url, :string
    add_column :regions, :logo_alt, :string
    add_column :regions, :logo_title, :string
  end
end
