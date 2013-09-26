class RenameResortHolidayTypesToHolidayTypeBrochures < ActiveRecord::Migration
  def change
    rename_table :resort_holiday_types, :holiday_type_brochures
  end
end
