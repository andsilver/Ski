class CreateFlipKeyProperties < ActiveRecord::Migration
  def change
    create_table :flip_key_properties do |t|
      t.string :url, null: false
      t.text :xml_data

      t.timestamps
    end

    add_index :flip_key_properties, :url
  end
end
