class AddGoogleWebPropertyIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :google_web_property_id, :string, :default => '', :null => false
  end
end
