class RenameUnavailabilitiesToAvailabilities < ActiveRecord::Migration
  def change
    rename_table :unavailabilities, :availabilities
  end
end
