class CreateCurrencies < ActiveRecord::Migration
  def self.up
    create_table :currencies do |t|
      t.string :name, :default => '', :null => false
      t.string :unit, :default => '', :null => false
      t.boolean :pre, :default => true, :null => false
      t.string :code, :default => '', :null => false
      t.decimal :in_euros, :precision => 6, :scale => 4, :default => 1.0, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :currencies
  end
end
