class AddSourceUrlToImages < ActiveRecord::Migration
  def change
    add_column :images, :source_url, :text
  end
end
