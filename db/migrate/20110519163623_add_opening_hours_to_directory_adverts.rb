class AddOpeningHoursToDirectoryAdverts < ActiveRecord::Migration
  def change
    add_column :directory_adverts, :opening_hours, :string, :default => '', :null => false
  end
end
