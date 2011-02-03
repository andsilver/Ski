class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string :name, :default => '', :null => false
      t.string :iso_3166_1_alpha_2, :default => '', :null => false
      t.boolean :valid_for_resorts, :default => false, :null => false

      t.timestamps
    end
    add_index :countries, :valid_for_resorts
  end

  def self.down
    drop_table :countries
  end
end
