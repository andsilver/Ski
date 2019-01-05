source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.6'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
# Use Puma as the app server
gem 'puma', '~> 3.7'
gem 'will_paginate'
gem 'acts_as_list'
gem 'acts_as_tree'
gem 'image_science'
gem 'RubyInline'
gem 'rdiscount', '1.6.8'
gem 'spreadsheet', '~> 0.6.5'
gem 'xml-simple'
gem 'curb'
gem 'net-sftp', github: 'net-ssh/net-sftp'
gem 'prawn'
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
gem 'whenever', require: false

# Use Draper to decorate models
gem 'draper'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Use jquery as the JavaScript library
gem 'jquery-rails'

group :production do
  gem 'dalli'
end

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'simplecov', :require => false, :group => :test

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'factory_bot_rails'
  gem 'rspec-rails'

  # Run specs in parallel
  gem 'parallel_tests'
end

group :development do
  gem 'brakeman'
  gem 'guard-rspec', require: false
  gem 'guard-cucumber'

  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'shoulda-matchers', '~> 3.0'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'launchy'
  gem "railroad", "0.5.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
