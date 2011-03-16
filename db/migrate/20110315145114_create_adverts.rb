class CreateAdverts < ActiveRecord::Migration
  def self.up
    create_table :adverts do |t|
      t.integer :user_id, :null => false
      t.integer :months, :default => 3, :null => false
      t.datetime :starts_at
      t.datetime :expires_at
      t.boolean :moderated, :default => false, :null => false
      t.boolean :paused, :default => false, :null => false
      t.integer :views, :default => 0, :null => false
      t.integer :banner_advert_id
      t.integer :directory_advert_id
      t.integer :property_id

      t.timestamps
    end

    add_index :adverts, :user_id
    add_index :adverts, :banner_advert_id
    add_index :adverts, :directory_advert_id
    add_index :adverts, :property_id
  end

  def self.down
    drop_table :adverts
  end
end
