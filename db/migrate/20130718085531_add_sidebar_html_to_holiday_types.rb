class AddSidebarHtmlToHolidayTypes < ActiveRecord::Migration
  def change
    add_column :holiday_types, :sidebar_html, :text
  end
end
