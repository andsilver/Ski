class InterhomeNotifier < ActionMailer::Base
  default from: 'notifier@mychaletfinder.com'
  layout 'email'

  def booking_confirmation(details)
    @details = details
    mail(to: details[:customer_email], subject: 'My Chalet Finder Booking Confirmation')
  end

  def unavailability_report(accommodation, details)
    @accommodation = accommodation
    @details = details

    mail(to: 'ianf@yesl.co.uk', subject: 'Unavailability Report')
  end
end
