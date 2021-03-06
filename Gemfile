# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'active_model_serializers'
gem 'devise'
gem 'jbuilder', '~> 2.7'
gem 'mysql2', '>= 0.4.4'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.2'
gem 'sass-rails', '>= 6'
gem 'sorbet-rails', '~> 0.7.0'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'faker'
  gem 'rspec-rails', '~> 4.0.0'
  gem 'sorbet', '~> 0.5.0'
end

group :development do
  gem 'debase', '~> 0.2.4.1'
  gem 'listen', '>= 3.0.5', '< 3.3'
  gem 'rubocop', '~> 0.83.0'
  gem 'ruby-debug-ide', '~> 0.7.2'
  gem 'solargraph', '~> 0.39.7'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'simplecov', '~> 0.18.5'
  gem 'sqlite3', '~> 1.3', '>= 1.3.11'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
