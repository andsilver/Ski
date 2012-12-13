class InterhomeNotifier < ActionMailer::Base
  default from: 'notifier@mychaletfinder.com'
  layout 'email'

  def booking_confirmation(details)
    @details = details
    mail(to: details[:customer_email], subject: 'My Chalet Finder Booking Confirmation')
  end
end
