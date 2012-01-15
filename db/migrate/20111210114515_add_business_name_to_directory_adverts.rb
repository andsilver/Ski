class AddBusinessNameToDirectoryAdverts < ActiveRecord::Migration
  def change
    add_column :directory_adverts, :business_name, :string, :default => '', :null => false
  end
end
