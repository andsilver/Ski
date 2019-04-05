class CarouselSlide < ActiveRecord::Base
  validates_presence_of :caption, :image_url, :link

  acts_as_list

  before_validation :ensure_active_range

  def self.active
    where("active_from <= ? AND active_until >= ?", DateTime.now, DateTime.now)
  end

  def ensure_active_range
    self.active_from  = Date.today - 1.day if active_from.nil?
    self.active_until = Date.today + 10.years if active_until.nil?
  end

  def to_s
    caption
  end
end
