source 'http://rubygems.org'

gem 'rails', '3.1.4'
gem 'mysql2', '0.3.10'
#gem "will_paginate", "~> 3.0.pre2"
gem 'will_paginate', :git => 'git@github.com:bridgeutopia/will_paginate.git', :branch => 'rails3'
gem 'image_science', '1.2.1'
gem 'RubyInline', '3.8.6'
gem 'rdiscount', '1.6.8'
gem 'spreadsheet', '0.6.5.4'
gem 'rdoc'
gem 'xml-simple'
gem 'prawn', '0.11.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'

gem 'json'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

group :development do
  gem "mongrel"
end

group :test, :development do
  gem "autotest", "4.4.6"
  gem "rspec-rails", ">= 2.6.1"
  gem 'watchr'
  gem 'spork', '~> 0.9.0'
  gem "shoulda-matchers"
  gem "cucumber-rails", ">= 0.5"
  gem 'database_cleaner'
  gem "capybara"
  gem "launchy", ">= 0.3.7"
  gem "rcov"
  gem "railroad", "0.5.0"
end
