class CreateInterhomeInsideDescriptions < ActiveRecord::Migration
  def change
    create_table :interhome_inside_descriptions do |t|
      t.string :accommodation_code, :null => false
      t.text :description

      t.timestamps
    end

    add_index :interhome_inside_descriptions, :accommodation_code
  end
end
