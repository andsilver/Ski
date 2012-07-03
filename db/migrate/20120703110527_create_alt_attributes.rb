class CreateAltAttributes < ActiveRecord::Migration
  def change
    create_table :alt_attributes do |t|
      t.string :path, null: false
      t.string :alt_text, default: '', null: false

      t.timestamps
    end

    add_index :alt_attributes, :path
  end
end
