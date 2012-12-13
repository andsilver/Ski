class AddDirectoryAdvertCountToResorts < ActiveRecord::Migration
  def change
    add_column :resorts, :directory_advert_count, :integer, default: 0, null: false
  end
end
