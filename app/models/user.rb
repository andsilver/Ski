# frozen_string_literal: true

class User < ActiveRecord::Base
  VALID_EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  belongs_to :role
  belongs_to :billing_country, class_name: "Country", optional: true
  belongs_to :vat_country, class_name: "Country", optional: true
  belongs_to :coupon, optional: true
  belongs_to :image, optional: true

  has_many :directory_adverts, dependent: :destroy
  has_many :enquiries, -> { order "created_at DESC" }, dependent: :delete_all
  has_many :adverts, dependent: :delete_all
  has_many :adverts_in_basket, -> { where starts_at: nil }, class_name: "Advert"

  # TODO: these should probably exclude expired windows
  has_many :windows, -> { where(window_spot: true).order("expires_at DESC") }, class_name: "Advert"

  has_many :properties, dependent: :destroy
  has_many :properties_for_rent, -> { where listing_type: Property::LISTING_TYPE_FOR_RENT }, class_name: "Property"
  has_many :properties_for_sale, -> { where listing_type: Property::LISTING_TYPE_FOR_SALE }, class_name: "Property"
  has_many :images, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :orders_with_receipts, -> { where("status NOT IN (#{Order::WAITING_FOR_PAYMENT})").order("created_at DESC") }, class_name: "Order"

  has_many :airport_transfers, dependent: :delete_all

  attr_accessor :password

  validates_length_of :password, within: 5..40, if: :password_required?
  validates_format_of :google_web_property_id, with: /\AUA-\d\d\d\d\d\d(\d)?(\d)?(\d)?-\d(\d)?\Z/, allow_blank: true

  validates_presence_of :first_name
  validates_presence_of :last_name

  validates_uniqueness_of :email
  validates_format_of :email, with: VALID_EMAIL_FORMAT

  validates_format_of :vat_number, with: /\A(
    (AT)?U[0-9]{8} |                              # Austria
    (BE)?0?[0-9]{9} |                             # Belgium
    (BG)?[0-9]{9,10} |                            # Bulgaria
    (CY)?[0-9]{8}L |                              # Cyprus
    (CZ)?[0-9]{8,10} |                            # Czech Republic
    (DE)?[0-9]{9} |                               # Germany
    (DK)?[0-9]{8} |                               # Denmark
    (EE)?[0-9]{9} |                               # Estonia
    (EL|GR)?[0-9]{9} |                            # Greece
    (ES)?[0-9A-Z][0-9]{7}[0-9A-Z] |               # Spain
    (FI)?[0-9]{8} |                               # Finland
    (FR)?[0-9A-Z]{2}[0-9]{9} |                    # France
    (GB)?([0-9]{9}([0-9]{3})?|[A-Z]{2}[0-9]{3}) | # United Kingdom
    (HU)?[0-9]{8} |                               # Hungary
    (IE)?[0-9]S[0-9]{5}L |                        # Ireland
    (IT)?[0-9]{11} |                              # Italy
    (LT)?([0-9]{9}|[0-9]{12}) |                   # Lithuania
    (LU)?[0-9]{8} |                               # Luxembourg
    (LV)?[0-9]{11} |                              # Latvia
    (MT)?[0-9]{8} |                               # Malta
    (NL)?[0-9]{9}B[0-9]{2} |                      # Netherlands
    (PL)?[0-9]{10} |                              # Poland
    (PT)?[0-9]{9} |                               # Portugal
    (RO)?[0-9]{2,10} |                            # Romania
    (SE)?[0-9]{12} |                              # Sweden
    (SI)?[0-9]{8} |                               # Slovenia
    (SK)?[0-9]{10}                                # Slovakia
    )\Z/x, if: proc {|u| u.vat_country}

  validates_presence_of :billing_street
  validates_presence_of :billing_city
  validates_presence_of :phone
  validates_presence_of :role

  validates_format_of :website, with: /\A(#{URI.regexp(%w[http https])})\Z/, allow_blank: true

  validates_acceptance_of :terms_and_conditions, on: :create, accept: true

  before_save :encrypt_password
  before_validation :tidy_vat_number

  def empty_windows
    adverts.where("property_id IS NULL AND window_spot = 1 AND expires_at > ?", Time.zone.now).order("expires_at DESC")
  end

  def delete_old_windows
    windows.each {|w| w.delete && windows.delete(w) if w.old?}
  end

  def advertises_through_windows?
    role&.advertises_through_windows?
  end

  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{pass}--")
  end

  def self.authenticate(email, pass)
    user = find_by(email: email)
    user&.authenticated?(pass) ? user : nil
  end

  def authenticated?(pass)
    encrypted_password == User.encrypt(pass, salt)
  end

  def self.generate_forgot_password_token
    charset = %w[2 3 4 6 7 9 A C D E F G H J K L M N P Q R T V W X Y Z]
    (0...8).map { charset.to_a[rand(charset.size)] }.join
  end

  def has_properties_for_rent?
    properties_for_rent.count > 0
  end

  def has_properties_for_sale?
    properties_for_sale.count > 0
  end

  def has_adverts_in_basket?
    adverts_in_basket.count > 0
  end

  def directory_advert_in_basket
    adverts_in_basket.each do |a|
      return a.directory_advert if a.directory_advert
    end
    nil
  end

  def directory_adverts_so_far
    Advert.where(["user_id = ? AND directory_advert_id IS NOT NULL AND starts_at IS NOT NULL AND starts_at > DATE_SUB(NOW(), INTERVAL 365 DAY)",
                  id,]).count
  end

  def property_adverts_so_far
    Advert.where(["user_id = ? AND property_id IS NOT NULL AND starts_at IS NOT NULL AND starts_at > DATE_SUB(NOW(), INTERVAL 365 DAY)",
                  id,]).count
  end

  def adverts_so_far
    directory_adverts_so_far + property_adverts_so_far
  end

  def basket_contains? advert_object
    adverts_in_basket.each do |a|
      return true if a.object == advert_object
    end
    false
  end

  # Returns true if the user should pay VAT.
  # A user pays VAT when their country for checking VAT is in the EU and they
  # have not supplied a VAT number.
  # All customers in the UK for tax purposes should pay VAT, regardless of a
  # VAT number.
  #
  # :call-seq:
  #   pays_vat? -> true or false
  def pays_vat?
    (vat_number.blank? && country_for_checking_vat.in_eu?) || country_for_checking_vat.iso_3166_1_alpha_2 == "GB"
  end

  def country_for_checking_vat
    vat_country || billing_country
  end

  def tax_description
    pays_vat? ? "VAT" : "Zero Rated"
  end

  def to_s
    name
  end

  def name
    "#{first_name} #{last_name}"
  end

  def empty_basket
    adverts_in_basket.each { |a| a.delete }
  end

  # Returns advertisable objects (properties and directory adverts) that are
  # new. That is, objects that have not yet been advertised.
  def new_advertisables
    (properties + directory_adverts).select {|a| a.advert_status == :new}
  end

  def remove_expired_coupon
    if coupon&.expired?
      self.coupon = nil
      save
    end
  end

  protected

  def encrypt_password
    return if password.blank?
    if new_record?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now}--#{email}--")
    end
    self.encrypted_password = User.encrypt(password, salt)
  end

  def password_required?
    encrypted_password.blank? || !password.blank?
  end

  def tidy_vat_number
    self.vat_number = vat_country ? vat_number.upcase.gsub(/[^A-Z0-9]/, "") : ""
  end
end
