class AddDescriptionToTripAdvisorProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :trip_advisor_properties, :description, :text
  end
end
