class AddMegaMenuHtmlToHolidayTypes < ActiveRecord::Migration
  def change
    add_column :holiday_types, :mega_menu_html, :text
  end
end
