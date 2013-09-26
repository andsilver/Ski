class MakeHolidayTypeBrochuresPolymorphic < ActiveRecord::Migration
  def change
    rename_column :holiday_type_brochures, :resort_id, :brochurable_id
    add_column :holiday_type_brochures, :brochurable_type, :string
  end
end
