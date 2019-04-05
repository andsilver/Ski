class UserNotifier < ActionMailer::Base
  include EmailSetup
  default from: "notifier@mychaletfinder.com"
  layout "email"

  def token user, domain
    @id = user.id
    @name = user.name
    @token = user.forgot_password_token
    @domain = domain
    mail(to: user.email, subject: "My Chalet Finder: how to change your password")
  end

  def welcome user, password, domain
    @name = user.name
    @email = user.email
    @password = password
    @domain = domain
    mail(to: user.email, subject: "Welcome to My Chalet Finder")
  end
end
