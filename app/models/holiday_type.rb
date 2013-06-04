class HolidayType < ActiveRecord::Base
  validates :name, presence: :true, uniqueness: true
  validates :slug, presence: :true, uniqueness: true
end
