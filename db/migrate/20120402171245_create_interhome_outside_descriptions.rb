class CreateInterhomeOutsideDescriptions < ActiveRecord::Migration
  def change
    create_table :interhome_outside_descriptions do |t|
      t.string :accommodation_code, :null => false
      t.text :description

      t.timestamps
    end

    add_index :interhome_outside_descriptions, :accommodation_code
  end
end
