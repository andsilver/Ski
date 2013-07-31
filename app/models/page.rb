class Page < ActiveRecord::Base
  validates :path, :title, presence: true

  validates :path, uniqueness: true

  validates :description, :path, :title, length: { maximum: 255 }

  belongs_to :footer
end
