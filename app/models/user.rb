class User < ActiveRecord::Base
  has_many :properties

  attr_accessor :password

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
