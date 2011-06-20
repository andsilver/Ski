class AddShortStaysAndChildrenWelcomeToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :children_welcome, :boolean, :default => false, :null => false
    add_column :properties, :short_stays, :boolean, :default => false, :null => false
  end
end
