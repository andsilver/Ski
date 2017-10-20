class InterhomeNotifier < ActionMailer::Base
  include EmailSetup
  default from: 'notifier@mychaletfinder.com'
  layout 'email'

  def booking_confirmation(details)
    @details = details
    mail(to: details[:customer_email], subject: 'My Chalet Finder Booking Confirmation')
  end

  def unavailability_report(accommodation, details)
    @accommodation = accommodation
    @details = details

    mail(
      to: 'ianfleeton+mychaletfinder@gmail.com',
      subject: 'Unavailability Report'
    )
  end
end
