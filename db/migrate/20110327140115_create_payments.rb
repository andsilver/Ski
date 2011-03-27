class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.integer :order_id
      t.string :service_provider
      t.string :installation_id
      t.string :cart_id
      t.string :description
      t.string :amount
      t.string :currency
      t.boolean :test_mode
      t.string :name
      t.string :address
      t.string :postcode
      t.string :country
      t.string :telephone
      t.string :fax
      t.string :email
      t.string :transaction_id
      t.string :transaction_status
      t.string :transaction_time
      t.text :raw_auth_message
      t.boolean :accepted

      t.timestamps
    end

    add_index :payments, :order_id
    add_index :payments, :created_at
  end

  def self.down
    drop_table :payments
  end
end
