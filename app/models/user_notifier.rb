class UserNotifier < ActionMailer::Base
  default :from => 'info@myskichalet.co.uk'

  def token user, domain
    @id = user.id
    @name = user.name
    @token = user.forgot_password_token
    @domain = domain
    mail(:to => user.email, :subject => 'My Ski Chalet: how to change your password')
  end
end
