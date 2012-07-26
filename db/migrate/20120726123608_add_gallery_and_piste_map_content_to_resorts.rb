class AddGalleryAndPisteMapContentToResorts < ActiveRecord::Migration
  def change
    add_column :resorts, :gallery_content, :text, default: ''
    add_column :resorts, :piste_map_content, :text, default: ''
  end
end
