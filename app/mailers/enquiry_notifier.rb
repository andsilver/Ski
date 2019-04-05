class EnquiryNotifier < ActionMailer::Base
  include EmailSetup
  default from: "notifier@mychaletfinder.com"
  layout "email"

  def notify enquiry, property
    @enquiry = enquiry
    @property = property
    cc = []
    if enquiry.user.enquiry_cc_emails.present?
      cc = enquiry.user.enquiry_cc_emails.split(",").map { |e| e.strip }
    end
    mail(
      to: enquiry.user.email,
      cc: cc,
      subject: "My Chalet Finder: Enquiry for property ##{property.id}"
    )
  end
end
