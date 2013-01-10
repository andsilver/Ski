class RemoveImageIdFromResorts < ActiveRecord::Migration
  def up
    remove_column :resorts, :image_id
  end

  def down
    add_column :resorts, :image_id
  end
end
