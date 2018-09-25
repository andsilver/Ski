# frozen_string_literal: true

class RemoveHotels < ActiveRecord::Migration[5.1]
  def up
    remove_column :resorts, :hotel_count
    remove_column :roles, :advertises_hotels
  end

  def down
    add_column :roles, :advertises_hotels, :boolean, default: false, null: false
    add_column :resorts, :hotel_count, :integer, default: 0, null: false
  end
end
