# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
MySkiChalet::Application.initialize!

# Don't verify certificates
ActionMailer::Base.smtp_settings = {
  openssl_verify_mode: 'none'
}
