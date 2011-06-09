class FirstNameAndLastNameForUsers < ActiveRecord::Migration
  def up
    remove_column :users, :name
    add_column :users, :first_name, :string, :default => '', :null => false
    add_column :users, :last_name, :string, :default => '', :null => false
    add_index :users, :last_name
  end

  def down
    remove_column :users, :last_name
    remove_column :users, :first_name
    add_column :users, :name, :string, :default => '', :null => false
  end
end
