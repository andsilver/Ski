class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites do |t|
      t.integer :property_id, :null => false
      t.integer :unregistered_user_id, :null => false

      t.timestamps
    end

    add_index :favourites, :property_id
    add_index :favourites, :unregistered_user_id
  end
end
