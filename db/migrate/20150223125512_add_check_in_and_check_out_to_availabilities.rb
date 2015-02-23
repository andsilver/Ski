class AddCheckInAndCheckOutToAvailabilities < ActiveRecord::Migration
  def change
    add_column :availabilities, :check_in, :boolean, null: false
    add_column :availabilities, :check_out, :boolean, null: false
  end
end
