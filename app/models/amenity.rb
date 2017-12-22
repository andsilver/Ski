# frozen_string_literal: true

class Amenity < ApplicationRecord
  has_and_belongs_to_many :properties
  validates_uniqueness_of :name
end
