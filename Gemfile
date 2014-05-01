source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0'
gem 'mysql2'
gem 'will_paginate'
gem 'acts_as_list'
gem 'acts_as_tree'
gem 'image_science', '1.2.3'
gem 'RubyInline'
gem 'rdiscount', '1.6.8'
gem 'spreadsheet', '0.6.5.4'
gem 'xml-simple'
gem 'curb'
gem 'prawn'
gem 'newrelic_rpm'
gem 'exception_notification', git: 'git://github.com/smartinez87/exception_notification.git'
gem 'liquid'
gem 'aws-sdk'
gem 'sanitize'
gem 'slim', '~> 2.0.0'

# Use Draper to decorate models
gem 'draper'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
gem 'libv8'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'google-analytics-turbolinks'

group :production do
  gem 'dalli'
end

group :development do
  gem 'brakeman'
  gem 'thin'
end

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'guard-rspec', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'simplecov', :require => false, :group => :test

group :test, :development do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end

group :test do
  gem 'shoulda-matchers'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem "capybara"
  gem 'launchy'
  gem "railroad", "0.5.0"
end
