class UserNotifier < ActionMailer::Base
  default :from => 'notifier@mychaletfinder.com'

  def token user, domain
    @id = user.id
    @name = user.name
    @token = user.forgot_password_token
    @domain = domain
    mail(:to => user.email, :subject => 'My Chalet Finder: how to change your password')
  end

  def welcome user, domain
    @name = user.name
    @domain = domain
    mail(:to => user.email, :subject => 'Welcome to My Chalet Finder')
  end
end
