class AddLateAvailabilityToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :late_availability, :boolean, default: true
    add_index :properties, :late_availability
  end
end
