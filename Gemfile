source 'https://rubygems.org'

gem 'rails', '3.2.3'

gem 'mysql2'

group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platform => :ruby
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'pry'
  gem 'pry-rails'
  gem 'awesome_print'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'guard'
  gem 'guard-rspec'
  gem 'spork'
  gem 'guard-spork'
  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'quiet_assets'

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

# Active Admin back end
gem 'activeadmin'
gem 'sass-rails'
gem 'meta_search', '>= 1.1.0.pre'

gem 'kaminari'
gem 'acts_as_permalink', '0.3.2'
gem 'rdiscount' # Markdown
gem 'carrierwave'
