class EnquiryNotifier < ActionMailer::Base
  default from: "notifier@mychaletfinder.com"
  layout 'email'

  def notify enquiry, property
    @enquiry = enquiry
    @property = property
    mail(to: enquiry.user.email,
      subject: "My Chalet Finder: Enquiry for property ##{property.id}")
  end
end
