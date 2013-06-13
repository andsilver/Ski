source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.rc2'
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

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0.rc2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', :platforms => :ruby
gem 'libv8', '= 3.11.8.4'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

group :development do
  gem 'brakeman'
  gem 'thin'
end

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

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
