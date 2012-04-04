class AddPermalinkToInterhomeAccommodation < ActiveRecord::Migration
  def change
    add_column :interhome_accommodations, :permalink, :string
    add_index :interhome_accommodations, :permalink
  end
end
