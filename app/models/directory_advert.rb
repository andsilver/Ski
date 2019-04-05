# frozen_string_literal: true

class DirectoryAdvert < ActiveRecord::Base
  include AdvertBehaviours

  CURRENTLY_ADVERTISED = ["id IN (SELECT adverts.directory_advert_id FROM adverts WHERE adverts.directory_advert_id=directory_adverts.id AND adverts.expires_at > NOW())"]

  belongs_to :category
  belongs_to :resort
  belongs_to :user
  belongs_to :image, dependent: :destroy, optional: true

  has_many :adverts, dependent: :nullify

  has_many :clicks, -> { where(action_type: TrackedAction.action_types[:click]) }, class_name: "TrackedAction", as: :trackable

  validates_presence_of :category
  validates_presence_of :resort
  validates_presence_of :user
  validates_presence_of :business_name
  validates_presence_of :business_address
  validates :strapline, presence: true, length: 1..255
  validates_format_of :url, with: /\A(#{URI.regexp(%w[http https])})\Z/, allow_blank: true

  def to_s
    "#{business_name} in #{resort}"
  end

  def name
    business_name
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

  def record_dimensions dimensions
    self.width, self.height = dimensions
    save
  end

  def basket_advert_type_description
    "Directory Advert"
  end

  def self.advertised_in(category, resort)
    conditions = CURRENTLY_ADVERTISED.dup
    conditions[0] += " AND category_id = ? AND resort_id = ?"
    conditions << category.id
    conditions << resort.id
    DirectoryAdvert.where(conditions)
  end
end
