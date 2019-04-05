class AddMultiColPrimaryKeyToAvailabilities < ActiveRecord::Migration[5.1]
  def change
    remove_index :availabilities, name: "index_availabilities_on_property_id_and_start_date"
    add_index :availabilities, [:start_date, :property_id]
    execute "ALTER TABLE availabilities ADD PRIMARY KEY (start_date, property_id);"
  end
end
