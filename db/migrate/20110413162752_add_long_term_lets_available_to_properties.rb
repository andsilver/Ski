class AddLongTermLetsAvailableToProperties < ActiveRecord::Migration
  def self.up
    add_column :properties, :long_term_lets_available, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :properties, :long_term_lets_available
  end
end
