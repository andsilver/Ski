# frozen_string_literal: true

class RemoveFavourites < ActiveRecord::Migration[5.1]
  def change
    drop_table :favourites
    drop_table :unregistered_users
  end
end
