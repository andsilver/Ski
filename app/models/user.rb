class User < ActiveRecord::Base
  belongs_to :role
  belongs_to :billing_country, :class_name => 'Country'
  belongs_to :coupon

  has_many :directory_adverts
  has_many :enquiries, :dependent => :delete_all
  has_many :adverts
  has_many :adverts_in_basket, :class_name => 'Advert', :conditions => {:starts_at => nil}
  has_many :properties
  has_many :properties_for_rent, :class_name => 'Property', :conditions => {:for_sale => false}
  has_many :properties_for_sale, :class_name => 'Property', :conditions => {:for_sale => true}
  has_many :orders
  has_many :orders_with_receipts, :class_name => 'Order', :conditions => "status NOT IN (#{Order::WAITING_FOR_PAYMENT})",
    :order => 'created_at DESC'

  attr_protected :role_id
  attr_protected :coupon_id

  attr_accessor :password

  validates_length_of :password, :within => 5..40, :if => :password_required?

  validates_length_of :name, :within => 5..40

  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates_presence_of :billing_street
  validates_presence_of :billing_city
  validates_presence_of :billing_country_id
  validates_presence_of :role_id

  validates_acceptance_of :terms_and_conditions, :on => :create, :accept => true

  before_save :encrypt_password

  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{pass}--")
  end

  def self.authenticate(email, pass)
    user = find_by_email(email)
    user && user.authenticated?(pass) ? user : nil
  end

  def authenticated?(pass)
    encrypted_password == User.encrypt(pass, salt)
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

  def directory_adverts_so_far
    Advert.count(
      :conditions => ['user_id = ? AND directory_advert_id IS NOT NULL AND starts_at IS NOT NULL',
      id])
  end

  def property_adverts_so_far
    Advert.count(
      :conditions => ['user_id = ? AND property_id IS NOT NULL AND starts_at IS NOT NULL',
      id])
  end

  def adverts_so_far
    directory_adverts_so_far + property_adverts_so_far
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
end
