class EnquiryNotifier < ActionMailer::Base
  default :from => "notifier@myskichalet.co.uk"

  def notify enquiry, property
    @enquiry = enquiry
    mail(:to => enquiry.user.email,
      :subject => "My Ski Chalet: Enquiry for property ##{property.id}")
  end
end
