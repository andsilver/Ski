class RemoveClicksFromDirectoryAdverts < ActiveRecord::Migration
  def up
    remove_column :directory_adverts, :clicks
  end

  def down
    add_column :directory_adverts, :clicks, :integer, default: 0, null: false
  end
end
