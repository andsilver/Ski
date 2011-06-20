class CreateAirports < ActiveRecord::Migration
  def change
    create_table :airports do |t|
      t.string :name, :default => '', :null => false
      t.string :code, :default => '', :null => false
      t.integer :country_id, :null => false

      t.timestamps
    end
  end
end
