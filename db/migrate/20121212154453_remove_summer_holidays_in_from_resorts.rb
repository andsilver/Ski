class RemoveSummerHolidaysInFromResorts < ActiveRecord::Migration
  def up
    remove_column :resorts, :summer_holidays_in
  end

  def down
    add_column :resorts, :summer_holidays_in, :text
  end
end
