class EmailAFriendNotifier < ActionMailer::Base
  def notify form, property
    @form = form
    @property = property
    mail(:to => form.friends_email, :from => form.your_email,
      :subject => "Your friend wants to show you a property on My Ski Chalet")
  end
end
