class DirectoryAdvert < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  has_many :adverts

  validates_presence_of :category
  validates_presence_of :user
  validates_presence_of :business_address

  def name
    user.business_name
  end

  PRICES = { 1 => 1000, 3 => 2700, 6 => 4800, 9 => 6300, 12 => 7200 }
  def price(advert, directory_adverts_so_far)
    PRICES[advert.months]
  end

  def current_advert
    Advert.where("directory_advert_id = ? AND expires_at > ?", id, Time.now).first
  end
end
