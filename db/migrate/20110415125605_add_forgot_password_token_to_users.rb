class AddForgotPasswordTokenToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :forgot_password_token, :string, :default => '', :null => false
  end

  def self.down
    remove_column :users, :forgot_password_token
  end
end
