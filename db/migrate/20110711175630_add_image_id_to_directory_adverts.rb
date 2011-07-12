class AddImageIdToDirectoryAdverts < ActiveRecord::Migration
  def change
    add_column :directory_adverts, :image_id, :integer
  end
end
