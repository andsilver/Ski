class DirectoryAdvert < ActiveRecord::Base
  include AdvertBehaviours

  belongs_to :category
  belongs_to :resort
  belongs_to :user
  belongs_to :image, :dependent => :destroy

  has_many :adverts, :dependent => :delete_all

  validates_presence_of :category
  validates_presence_of :resort
  validates_presence_of :user
  validates_presence_of :business_address
  validates_presence_of :strapline

  def name
    user.business_name
  end

  def price(advert, directory_adverts_so_far)
    Website.first.directory_advert_price * 100
  end

  def valid_months
    [default_months]
  end

  def default_months
    12
  end
end
