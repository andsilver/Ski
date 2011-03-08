class EnquiryNotifier < ActionMailer::Base
  default :from => "notifier@myskichalet.co.uk"

  def notify enquiry
    @enquiry = enquiry
    mail(:to => enquiry.user.email)
  end
end
