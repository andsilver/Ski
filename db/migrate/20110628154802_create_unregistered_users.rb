class CreateUnregisteredUsers < ActiveRecord::Migration
  def change
    create_table :unregistered_users do |t|

      t.timestamps
    end
  end
end
