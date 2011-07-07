class AddUserIndexToDirectoryAdverts < ActiveRecord::Migration
  def change
    add_index :directory_adverts, :user_id
  end
end
