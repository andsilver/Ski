class CreateUnavailabilities < ActiveRecord::Migration
  def change
    create_table :unavailabilities do |t|
      t.integer :property_id
      t.date :start_date

      t.timestamps
    end

    add_index :unavailabilities, :property_id
    add_index :unavailabilities, :start_date
    add_index :unavailabilities, [:property_id, :start_date]
  end
end
