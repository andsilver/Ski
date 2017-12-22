# frozen_string_literal: true

class CreateAmenities < ActiveRecord::Migration[5.1]
  def change
    create_table :amenities do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :amenities_properties, id: false do |t|
      t.belongs_to :amenity, index: true
      t.belongs_to :property, index: true
    end
  end
end
