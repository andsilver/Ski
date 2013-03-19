source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'mysql2'
gem 'will_paginate', :git => 'git://github.com/bridgeutopia/will_paginate.git', :branch => 'rails3'
gem 'image_science', '1.2.3'
gem 'RubyInline'
gem 'rdiscount', '1.6.8'
gem 'spreadsheet', '0.6.5.4'
gem 'rdoc'
gem 'xml-simple'
gem 'curb'
gem 'prawn'
gem 'newrelic_rpm'
gem 'exception_notification'
gem 'liquid'
gem 'aws-sdk'
gem 'sanitize'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby
  gem 'libv8', '= 3.11.8.4'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :development do
  gem 'brakeman'
  gem 'thin'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

gem 'simplecov', :require => false, :group => :test

group :test do
  gem "autotest", "4.4.6"
  gem 'rspec-rails'
  gem 'watchr'
  gem 'spork'
  gem "shoulda-matchers", "~> 1.4.2" # temporary hold for require cannot load such file -- rspec
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem "capybara"
  gem 'launchy'
  gem "railroad", "0.5.0"
end
