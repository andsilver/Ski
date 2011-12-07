class AddUrlToDirectoryAdverts < ActiveRecord::Migration
  def change
    add_column :directory_adverts, :url, :string, :default => '', :null => false
  end
end
