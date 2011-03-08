class CreateEnquiries < ActiveRecord::Migration
  def self.up
    create_table :enquiries do |t|
      t.integer :user_id, :null => false
      t.integer :property_id
      t.string :name, :null => false
      t.string :email, :null => false
      t.string :phone, :null => false
      t.string :postcode, :null => false
      t.date :date_of_arrival
      t.date :date_of_departure
      t.text :comments, :default => '', :null => false
      t.boolean :contact_me, :default => false, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :enquiries
  end
end
