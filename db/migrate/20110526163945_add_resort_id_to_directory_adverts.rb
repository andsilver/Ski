class AddResortIdToDirectoryAdverts < ActiveRecord::Migration
  def change
    add_column :directory_adverts, :resort_id, :integer, :null => :false
    add_index :directory_adverts, :resort_id
    remove_column :categories, :resort_id
  end
end
