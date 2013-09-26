class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.references :country, index: true
      t.string :name, null: false
      t.text :info

      t.timestamps
    end
  end
end
