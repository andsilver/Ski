source 'https://rubygems.org'

gem 'rails', '4.0.0.beta1'
gem 'mysql2'
gem 'will_paginate'
gem 'image_science', '1.2.3'
gem 'RubyInline'
gem 'rdiscount', '1.6.8'
gem 'spreadsheet', '0.6.5.4'
gem 'rdoc'
gem 'xml-simple'
gem 'curb'
gem 'prawn'
gem 'newrelic_rpm'
gem 'exception_notification', git: 'git://github.com/smartinez87/exception_notification.git'
gem 'liquid'
gem 'aws-sdk'
gem 'sanitize'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 4.0.0.beta1'
  gem 'coffee-rails', '~> 4.0.0.beta1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby
  gem 'libv8', '= 3.11.8.4'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

group :development do
  gem 'brakeman'
  gem 'thin'
end

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', group: :development

# To use debugger
# gem 'debugger'

gem 'simplecov', :require => false, :group => :test

group :test, :development do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end

group :test do
  gem "autotest", "4.4.6"
  gem 'watchr'
  gem 'spork-rails', github: 'A-gen/spork-rails'
  gem "shoulda-matchers", "~> 1.4.2" # temporary hold for require cannot load such file -- rspec
  gem 'cucumber-rails', require: false
  gem 'database_cleaner', '1.0.0.RC1'
  gem "capybara"
  gem 'launchy'
  gem "railroad", "0.5.0"
end
