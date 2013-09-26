class AddVisibleOnMenuToHolidayTypes < ActiveRecord::Migration
  def change
    add_column :holiday_types, :visible_on_menu, :boolean, default: true, null: false
  end
end
