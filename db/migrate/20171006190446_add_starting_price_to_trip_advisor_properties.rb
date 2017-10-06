class AddStartingPriceToTripAdvisorProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :trip_advisor_properties, :starting_price, :integer, null: false
    add_column :trip_advisor_properties, :currency_id, :integer, null: false
    add_index :trip_advisor_properties, :currency_id
  end
end
