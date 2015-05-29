class DirectoryAdvert < ActiveRecord::Base
  include AdvertBehaviours

  CURRENTLY_ADVERTISED = ["id IN (SELECT adverts.directory_advert_id FROM adverts WHERE adverts.directory_advert_id=directory_adverts.id AND adverts.expires_at > NOW())"]

  belongs_to :category
  belongs_to :resort
  belongs_to :user
  belongs_to :image, dependent: :destroy
  belongs_to :banner_image, class_name: 'Image', dependent: :destroy

  has_many :adverts, dependent: :nullify

  has_many :clicks, -> { where(action_type: TrackedAction.action_types[:click]) }, class_name: 'TrackedAction', as: :trackable

  validates_presence_of :category
  validates_presence_of :resort
  validates_presence_of :user
  validates_presence_of :business_name
  validates_presence_of :business_address
  validates :strapline, presence: true, length: 1..255
  validates_format_of :url, with: /\A(#{URI::regexp(%w(http https))})\Z/, allow_blank: true

  def name
    business_name
  end

  def price(advert, directory_adverts_so_far)
    if is_banner_advert?
      BannerPrice.price_for_advert_number(directory_adverts_so_far) * 100
    else
      Website.first.directory_advert_price * 100
    end
  end

  def valid_months
    [default_months]
  end

  def default_months
    12
  end

  def record_dimensions dimensions
    self.width, self.height = dimensions
    save
  end

  def basket_advert_type_description
    is_banner_advert? ? 'Banner Advert + Free Directory Advert' : 'Directory Advert'
  end

  def self.advertised_in(category, resort)
    conditions = CURRENTLY_ADVERTISED.dup
    conditions[0] += " AND category_id = ? AND resort_id = ?"
    conditions << category.id
    conditions << resort.id
    DirectoryAdvert.where(conditions)
  end

  def self.banner_adverts_for(resort, dimensions, qty)
    conditions = CURRENTLY_ADVERTISED.dup
    conditions[0] += " AND resort_id = ?" if resort
    conditions[0] += " AND width = ? AND height = ?"
    conditions[0] += " AND banner_image_id IS NOT NULL"
    conditions[0] += " AND is_banner_advert = 1"
    conditions << resort.id if resort
    conditions << dimensions[0]
    conditions << dimensions[1]

    ads = []
    uncached do
      ads = DirectoryAdvert.where(conditions).order('RAND()').limit(qty)
    end

    ads.each {|ad| ad.current_advert.record_view}
    ads
  end

  # Returns small banner adverts for a place. Only resorts support advertising
  # at the moment so any other type of place will return an empty array.
  def self.small_banners_for(place, qty = 6)
    if place.is_a?(Resort)
      self.banner_adverts_for(place, [160, 200], qty)
    else
      []
    end
  end
end
