source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.7'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.13', '< 0.5'
gem 'will_paginate'
gem 'acts_as_list'
gem 'acts_as_tree'
gem 'image_science'
gem 'RubyInline'
gem 'rdiscount', '1.6.8'
gem 'spreadsheet', '~> 0.6.5'
gem 'xml-simple'
gem 'curb'
gem 'prawn'
gem 'newrelic_rpm'
gem 'exception_notification', git: 'git://github.com/smartinez87/exception_notification.git'
gem 'liquid', '~> 3.0'
gem 'aws-sdk', '~> 1'
gem 'sanitize'
gem 'slim', '~> 2.0.0'
# Easier Bootstrap forms
gem 'bootstrap_form'

# Run jobs in background processes
gem 'daemons'
gem 'delayed_job_active_record'

# Use Draper to decorate models
gem 'draper'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

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
  gem 'guard-rspec', require: false

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'simplecov', :require => false, :group => :test

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  gem 'factory_girl_rails'
  gem 'rspec-rails'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 1.7.2'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'shoulda-matchers', '~> 3.0'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem "capybara"
  gem 'launchy'
  gem 'selenium-webdriver'
  gem "railroad", "0.5.0"
end
