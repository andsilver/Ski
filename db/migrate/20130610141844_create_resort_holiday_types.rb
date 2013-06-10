class CreateResortHolidayTypes < ActiveRecord::Migration
  def change
    create_table :resort_holiday_types do |t|
      t.references :resort
      t.references :holiday_type

      t.timestamps
    end

    add_index :resort_holiday_types, :resort_id
    add_index :resort_holiday_types, :holiday_type_id
  end
end
