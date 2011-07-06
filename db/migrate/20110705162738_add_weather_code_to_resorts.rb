class AddWeatherCodeToResorts < ActiveRecord::Migration
  def change
    add_column :resorts, :weather_code, :text, :default => ''
  end
end
