class AddBookingUrlToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :booking_url, :string, default: '', null: false
  end
end
