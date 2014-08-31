source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

gem 'pg'
gem 'capistrano', '~> 2.15.0'
gem 'rvm-capistrano'
gem 'authlogic'
gem 'bcrypt', '~> 3.1.7'
gem 'state_machine'
gem 'scrypt'
gem 'active_model_serializers'
gem 'rack-contrib'
gem 'soulmate', require: 'soulmate/server'
gem 'faker'
gem 'twitter-bootstrap-rails'
gem 'less-rails'
gem 'sidekiq'
gem 'mail_view', :git => 'https://github.com/basecamp/mail_view.git'

group :development, :test do
  gem 'factory_girl_rails', require: false
  gem 'pry'
  gem 'rspec-rails'
end

group :development do
  gem 'spring'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem 'sqlite3'
  gem 'rspec'
end

group :production do
  gem 'unicorn'
end
