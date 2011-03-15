class User < ActiveRecord::Base
  belongs_to :role
  belongs_to :billing_country, :class_name => 'Country'
  has_many :directory_adverts
  has_many :enquiries, :dependent => :delete_all
  has_many :properties
  has_many :properties_for_rent, :class_name => 'Property', :conditions => {:for_sale => false}
  has_many :properties_for_sale, :class_name => 'Property', :conditions => {:for_sale => true}

  attr_protected :role_id

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
