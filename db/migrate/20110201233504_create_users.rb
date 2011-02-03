class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name, :default => '', :null => false
      t.string :email, :defailt => '', :null => false
      t.string :encrypted_password
      t.string :salt

      t.timestamps
    end
    add_index :users, :email
  end

  def self.down
    drop_table :users
  end
end
