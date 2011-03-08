class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name, :default => '', :null => false
      t.string :email, :default => '', :null => false
      t.string :encrypted_password
      t.string :salt
      t.boolean :admin, :default => false, :null => false

      t.string :website, :default => '', :null => false
      t.text   :description, :null => false

      t.string :billing_street,   :null => false
      t.string :billing_locality, :default => '', :null => false
      t.string :billing_city,     :null => false
      t.string :billing_county,   :default => '', :null => false
      t.string :billing_postcode, :default => '', :null => false
      t.integer :billing_country_id

      t.string :phone,    :default => '', :null => false
      t.string :mobile,   :default => '', :null => false

      t.string :business_name, :default => '', :null => false
      t.string :position,      :default => '', :null => false

      t.boolean :terms_and_conditions, :null => false

      t.timestamps
    end
    add_index :users, :email
  end

  def self.down
    drop_table :users
  end
end
