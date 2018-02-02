# frozen_string_literal: true

class Review < ApplicationRecord
  # Associations
  belongs_to :property

  # Validations
  validates_presence_of :author_location, :author_name, :content, :title
end
