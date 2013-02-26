class CreatePvAccommodations < ActiveRecord::Migration
  def change
    create_table :pv_accommodations do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.string :iso_3166_1, null: false
      t.string :iso_3166_2, null: false
      t.string :onu, null: false
      t.text :accroche_liste
      t.text :accroche_fiche
      t.text :description
      t.string :address_1, null: false
      t.string :address_2, null: false
      t.string :town, null: false
      t.string :postcode, null: false
      t.string :latitude, null: false
      t.string :longitude, null: false
      t.text :sports
      t.text :services
      t.string :price_table_url, null: false
      t.string :permalink, null: false

      t.timestamps
    end

    add_index :pv_accommodations, :code
    add_index :pv_accommodations, :permalink
  end
end
