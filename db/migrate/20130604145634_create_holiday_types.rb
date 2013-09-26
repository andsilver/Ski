class CreateHolidayTypes < ActiveRecord::Migration
  def change
    create_table :holiday_types do |t|
      t.string :name, null: false
      t.string :slug, null: false

      t.timestamps
    end
  end
end
