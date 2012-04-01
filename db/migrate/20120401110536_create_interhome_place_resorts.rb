class CreateInterhomePlaceResorts < ActiveRecord::Migration
  def change
    create_table :interhome_place_resorts do |t|
      t.integer :resort_id, :null => false
      t.string :interhome_place_code, :null => false

      t.timestamps
    end

    add_index :interhome_place_resorts, :resort_id
  end
end
