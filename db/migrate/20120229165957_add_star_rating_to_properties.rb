class AddStarRatingToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :star_rating, :integer, :default => 1, :null => false
  end
end
