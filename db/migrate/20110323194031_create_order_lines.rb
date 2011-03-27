class CreateOrderLines < ActiveRecord::Migration
  def self.up
    create_table :order_lines do |t|
      t.integer :order_id, :null => false
      t.string :description, :null => false
      t.integer :amount, :null => false
      t.integer :advert_id, :null => false

      t.timestamps
    end

    add_index :order_lines, :order_id
    add_index :order_lines, :advert_id
  end

  def self.down
    drop_table :order_lines
  end
end
