class AddGalleryAndPisteMapContentToResorts < ActiveRecord::Migration
  def change
    add_column :resorts, :gallery_content, :text
    add_column :resorts, :piste_map_content, :text
  end
end
