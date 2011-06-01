class CreateBannerAdverts < ActiveRecord::Migration
  def change
    create_table :banner_adverts do |t|
      t.integer :user_id, :null => false
      t.integer :resort_id, :null => false
      t.integer :image_id
      t.string :url, :null => false
      t.integer :width, :default => 0, :null => false
      t.integer :height, :default => 0, :null => false
      t.integer :clicks, :default => 0, :null => false

      t.timestamps
    end

    add_index :banner_adverts, :user_id
    add_index :banner_adverts, :resort_id
  end
end
