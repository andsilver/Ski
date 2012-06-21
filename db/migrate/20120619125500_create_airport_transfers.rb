class CreateAirportTransfers < ActiveRecord::Migration
  def change
    create_table :airport_transfers do |t|
      t.integer :airport_id, null: false
      t.integer :resort_id, null: false
      t.integer :user_id, null: false
      t.boolean :publicly_visible, default: true, null: false

      t.timestamps
    end

    add_index :airport_transfers, :airport_id
    add_index :airport_transfers, :resort_id
    add_index :airport_transfers, :user_id
  end
end
