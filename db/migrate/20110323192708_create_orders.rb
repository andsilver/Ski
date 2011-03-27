class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :user_id
      t.string :order_number, :null => false
      t.string :email, :null => false
      t.integer :status, :null => false
      t.string :name, :null => false
      t.string :address, :null => false
      t.integer :country_id, :null => false
      t.string :phone, :null => false
      t.integer :total, :null => false

      t.timestamps
    end

    add_index :orders, :user_id
    add_index :orders, :order_number
    add_index :orders, :email
    add_index :orders, :created_at
  end

  def self.down
    drop_table :orders
  end
end
