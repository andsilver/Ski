class BannerAdvert < ActiveRecord::Base
  include AdvertBehaviours

  belongs_to :resort
  belongs_to :user

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
end
