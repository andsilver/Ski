source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 5.2.1"
# Use mysql as the database for Active Record
gem "mysql2", ">= 0.4.4", "< 0.6.0"
# Use Puma as the app server
gem "puma", "~> 3.11"
gem "will_paginate"
gem "acts_as_list"
gem "acts_as_tree"
gem "image_science"
gem "RubyInline"
gem "rdiscount", "1.6.8"
gem "spreadsheet", "~> 0.6.5"
gem "xml-simple"
gem "curb"
gem "net-sftp", github: "net-ssh/net-sftp"
gem "prawn"
gem "exception_notification", github: "smartinez87/exception_notification"
gem "liquid", "~> 3.0"
gem "aws-sdk", "~> 1"
gem "sanitize"
gem "slim", "~> 2.0.0"

gem "bootstrap", "~> 4.0.0"
# Easier Bootstrap forms
gem "bootstrap_form", github: "bootstrap-ruby/bootstrap_form"

# Run jobs in background processes
gem "daemons"
gem "delayed_job_active_record"
gem "whenever", require: false

# Use Draper to decorate models
gem "draper"

# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem "webpacker"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 4.2"
# Use jquery as the JavaScript library
gem "jquery-rails"

group :production do
  gem "dalli"
end

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.5"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem "simplecov", require: false, group: :test

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.1.0", require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "factory_bot_rails"
  gem "rspec-rails"

  # Run specs in parallel
  gem "parallel_tests"

  # Standard - Ruby style guide, linter, and formatter
  gem "standard"
end

group :development do
  gem "brakeman"
  gem "guard-rspec", require: false
  gem "guard-cucumber"

  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "spring-commands-rspec"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "shoulda-matchers", "~> 3.0"
  gem "cucumber-rails", require: false
  gem "database_cleaner"
  gem "launchy"
  gem "railroad", "0.5.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
