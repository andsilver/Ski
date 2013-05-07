class Page < ActiveRecord::Base
  validates :path, :title, presence: true

  validate :path, uniqueness: true

  validates :description, :path, :title, length: { maximum: 255 }

  belongs_to :footer
end
