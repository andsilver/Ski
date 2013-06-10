class HolidayType < ActiveRecord::Base
  validates :name, presence: :true, uniqueness: true
  validates :slug, presence: :true, uniqueness: true

  has_many :resort_holiday_types, dependent: :delete_all

  def to_param
    slug
  end

  def to_s
    name
  end
end
