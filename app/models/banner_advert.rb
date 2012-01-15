class BannerAdvert < ActiveRecord::Base
  include AdvertBehaviours

  validates_presence_of :resort
  validates_presence_of :user
  validates_presence_of :url

  def record_dimensions dimensions
    self.width, self.height = dimensions
    save
  end

  def self.adverts_for(resort, dimensions, qty)
    return [] if(rand > 0.7)

    conditions = CURRENTLY_ADVERTISED.dup
    conditions[0] += " AND resort_id = ? AND width = ? AND height = ?"
    conditions[0] += " AND image_id IS NOT NULL"
    conditions << resort.id
    conditions << dimensions[0]
    conditions << dimensions[1]

    ads = []
    uncached do
      ads = BannerAdvert.all(:order => 'RAND()', :conditions => conditions, :limit => qty)
    end

    ads.each {|ad| ad.current_advert.record_view}
    ads
  end

  def self.small_banners_for(resort, qty = 3)
    self.adverts_for(resort, [160, 200], qty)
  end
end
