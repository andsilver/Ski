class AddWindowToAdverts < ActiveRecord::Migration
  def change
    add_column :adverts, :window, :boolean, :default => false, :null => false
  end
end
