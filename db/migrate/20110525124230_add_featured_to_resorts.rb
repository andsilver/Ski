class AddFeaturedToResorts < ActiveRecord::Migration
  def change
    add_column :resorts, :featured, :boolean, :default => false, :null => false
    add_column :resorts, :feature, :text, :default => ''
    add_index :resorts, :featured
  end
end
