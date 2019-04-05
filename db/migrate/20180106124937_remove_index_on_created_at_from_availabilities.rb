class RemoveIndexOnCreatedAtFromAvailabilities < ActiveRecord::Migration[5.1]
  def change
    remove_index :availabilities, name: "index_availabilities_on_created_at"
  end
end
