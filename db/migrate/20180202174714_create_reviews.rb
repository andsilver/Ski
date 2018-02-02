# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :property_id, null: false
      t.integer :rating, null: false
      t.string :title, null: false
      t.text :content
      t.string :author_name, null: false
      t.string :author_location, null: false
      t.date :visited_on, null: false

      t.timestamps
    end
    add_index :reviews, :property_id
  end
end
