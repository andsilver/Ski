class AddAvailabilityToAvailabilities < ActiveRecord::Migration
  def change
    add_column :availabilities, :availability, :integer, limit: 1, null: false
  end
end
