class CreateInterhomeAccommodations < ActiveRecord::Migration
  def change
    create_table :interhome_accommodations do |t|
      t.string :code, :null => false
      t.string :name, :null => false
      t.string :country, :null => false
      t.string :region, :null => false
      t.string :place, :null => false
      t.string :zip, :null => false
      t.string :accommodation_type, :null => false
      t.string :details, :null => false
      t.integer :quality, :null => false
      t.integer :brand, :null => false
      t.integer :pax, :null => false
      t.integer :sqm, :null => false
      t.integer :floor, :null => false
      t.integer :rooms, :null => false
      t.integer :bedrooms, :null => false
      t.integer :toilets, :null => false
      t.integer :bathrooms, :null => false
      t.string :geodata_lat, :null => false
      t.string :geodata_lng, :null => false
      t.text :features
      t.string :themes, :null => false

      t.timestamps
    end

    add_index :interhome_accommodations, :code
  end
end
