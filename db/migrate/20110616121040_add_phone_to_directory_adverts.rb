class AddPhoneToDirectoryAdverts < ActiveRecord::Migration
  def change
    add_column :directory_adverts, :phone, :string, :default => '', :null => false
  end
end
