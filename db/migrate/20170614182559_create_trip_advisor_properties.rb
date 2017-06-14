class CreateTripAdvisorProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :trip_advisor_properties do |t|
      t.string :property_type
      t.integer :bedrooms
      t.integer :beds
      t.integer :sleeps
      t.integer :bathrooms
      t.string :title
      t.string :country
      t.string :city
      t.string :url
      t.string :status
      t.decimal :review_average, precision: 2, scale: 1
      t.boolean :show_pin, null: false, default: false
      t.string :lat_long
      t.string :country_code
      t.string :postal_code
      t.string :search_url
      t.boolean :can_accept_inquiry, null: false, default: false
      t.string :booking_option
      t.integer :min_stay_high
      t.integer :min_stay_low
      t.integer :trip_advisor_location_id

      t.timestamps
    end

    add_index :trip_advisor_properties, :trip_advisor_location_id
  end
end
