class BannerAdvert < ActiveRecord::Base
  include AdvertBehaviours

  validates_presence_of :resort
  validates_presence_of :user
  validates_presence_of :url

  def record_dimensions dimensions
    self.width, self.height = dimensions
    save
  end

  def self.small_banners_for(resort, qty = 3)
    self.adverts_for(resort, [160, 200], qty)
  end
end
