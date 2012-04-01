class CreateInterhomePlaces < ActiveRecord::Migration
  def change
    create_table :interhome_places do |t|
      t.string :code, :null => false
      t.string :name, :null => false
      t.string :full_name, :null => false

      t.timestamps
    end

    add_index :interhome_places, :code
  end
end
