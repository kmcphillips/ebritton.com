source 'https://rubygems.org'

gem 'rails', '3.2.3'

gem 'mysql2'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platform => :ruby
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'pry'
  gem 'awesome_print'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'guard'
  gem 'guard-rspec'
  gem 'spork'
  gem 'guard-spork'

  if RUBY_PLATFORM.include? "darwin"
    gem 'growl'
  elsif RUBY_PLATFORM.include? "linux"
    gem 'libnotify'
  end

  gem 'thin'
end

gem 'jquery-rails'
gem 'capistrano'
gem 'haml'
gem 'haml-rails'
gem 'rmagick'
gem 'paperclip'
gem 'activeadmin'
gem 'will_paginate'
