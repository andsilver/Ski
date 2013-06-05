class HolidayType < ActiveRecord::Base
  validates :name, presence: :true, uniqueness: true
  validates :slug, presence: :true, uniqueness: true

  def to_param
    slug
  end

  def to_s
    name
  end
end
