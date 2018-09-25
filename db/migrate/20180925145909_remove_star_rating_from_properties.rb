# frozen_string_literal: true

class RemoveStarRatingFromProperties < ActiveRecord::Migration[5.1]
  def up
    remove_column :properties, :star_rating
  end

  def down
    add_column :properties, :star_rating, :integer, default: 1, null: false
  end
end
