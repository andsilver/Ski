class CreateInterhomePictures < ActiveRecord::Migration
  def change
    create_table :interhome_pictures do |t|
      t.integer :interhome_accommodation_id, :null => false
      t.string :picture_type, :null => false
      t.string :season, :null => false
      t.string :url, :null => false

      t.timestamps
    end

    add_index :interhome_pictures, :interhome_accommodation_id
  end
end
