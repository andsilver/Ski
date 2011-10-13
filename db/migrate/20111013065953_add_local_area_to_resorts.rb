class AddLocalAreaToResorts < ActiveRecord::Migration
  def change
    add_column :resorts, :local_area, :boolean, :default => false, :null => false
  end
end
