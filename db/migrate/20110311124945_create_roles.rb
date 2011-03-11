class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name
      t.boolean :select_on_signup
      t.boolean :admin
      t.boolean :flag_new_development

      t.timestamps
    end

    remove_column :users, :admin
    add_column :users, :role_id, :integer, :null => false
  end

  def self.down
    remove_column :users, :role_id
    add_column :users, :admin, :boolean, :default => false, :null => false
    drop_table :roles
  end
end
