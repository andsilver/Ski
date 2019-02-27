class AddColumnsToResort < ActiveRecord::Migration[5.2]
  def change
    add_column :resorts, :image_url, :string
    add_column :resorts, :strapline, :string
  end
end
