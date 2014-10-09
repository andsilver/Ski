module FlipKey
  # Returns the directory where FlipKey data files are stored locally.
  def self.directory
    'flip_key'
  end

  # Returns the FlipKey User.
  def self.user
    User.find_by(email: user_email)
  end

  # Returns the email address of the FlipKey user.
  def self.user_email
    'flipkey@mychaletfinder.com'
  end
end
