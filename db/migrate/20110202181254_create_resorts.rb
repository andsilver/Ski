class CreateResorts < ActiveRecord::Migration
  def self.up
    create_table :resorts do |t|
      t.integer :country_id, :default => 0, :null => false
      t.string :name, :default => 0, :null => false

      t.timestamps
    end
    add_index :resorts, :country_id
  end

  def self.down
    drop_table :resorts
  end
end
