class AddStraplineToDirectoryAdverts < ActiveRecord::Migration
  def change
    add_column :directory_adverts, :strapline, :string, :default => '', :null => false
  end
end
