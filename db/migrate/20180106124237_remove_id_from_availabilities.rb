class RemoveIdFromAvailabilities < ActiveRecord::Migration[5.1]
  def up
    remove_column :availabilities, :id
  end
end
