class AddPhotosToPvAccommodations < ActiveRecord::Migration
  def change
    add_column :pv_accommodations, :photos, :text
  end
end
