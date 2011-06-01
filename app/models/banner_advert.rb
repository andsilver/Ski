class BannerAdvert < ActiveRecord::Base
  include AdvertBehaviours

  CURRENTLY_ADVERTISED = ["id IN (SELECT adverts.banner_advert_id FROM adverts WHERE adverts.banner_advert_id=banner_adverts.id AND adverts.expires_at > NOW())"]

  belongs_to :resort
  belongs_to :user
  belongs_to :image

  has_many :adverts

  validates_presence_of :resort
  validates_presence_of :user
  validates_presence_of :url

  def name
    user.business_name
  end

  def price(advert, banner_adverts_so_far)
    Website.first.directory_advert_price * 100
  end

  def valid_months
    [default_months]
  end

  def default_months
    12
  end

  def self.wide_skyscraper_for(resort)
    conditions = CURRENTLY_ADVERTISED.dup
    conditions[0] += " AND resort_id = ?"
    conditions[0] += " AND image_id IS NOT NULL"
    conditions << resort.id

    ad = nil
    uncached do
      ad = BannerAdvert.all(:order => 'RAND()', :conditions => conditions).first
    end

    ad.current_advert.record_view if ad
    ad
  end
end
