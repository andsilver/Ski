class AddLogoToResort < ActiveRecord::Migration[5.2]
  def change
    add_column :resorts, :logo_url, :string
    add_column :resorts, :logo_alt, :string
    add_column :resorts, :logo_title, :string
  end
end
