class CreatePvPlaceResorts < ActiveRecord::Migration
  def change
    create_table :pv_place_resorts do |t|
      t.integer :resort_id, null: false
      t.string :pv_place_code, null: false

      t.timestamps
    end

    add_index :pv_place_resorts, :pv_place_code
    add_index :pv_place_resorts, :resort_id
  end
end
