class AddTerraceToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :terrace, :boolean, :default => false, :null => false
  end
end
