source 'https://rubygems.org'
ruby '2.6.0'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'rails', '~> 6.0.2.1'

# WebServer
gem 'puma', '~> 4.3'
gem 'rack-cors', '~> 1.1.1'

# Database
gem 'pg', '~> 0.18.4'

# Environment variables
gem 'dotenv-rails', '~> 2.7.4'

# Async worker
gem 'sidekiq', '~> 6.0.4'

# Authentication
gem 'devise', '~> 4.7.1'
gem 'devise_token_auth', '~> 1.1.2'

# Serializing json views
gem 'jb', '~> 0.7.0'

# Pagination
gem 'pagy', '~> 3.7'

# Monitoring errors
gem 'sentry-raven', '~> 2.13.0'

group :development, :test do
  gem 'bullet', '~> 6.1.0'
  gem 'byebug', '>= 11.0.1', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 5.1.1'
  gem 'faker', '~> 2.10.1'
  gem 'rspec-rails', '~> 3.8.2'
end

group :development do
  gem 'annotate', '~> 3.0.3'
  gem 'letter_opener', '~> 1.7.0'
  gem 'listen', '>= 3.0.5', '< 3.3'
  gem 'reek', '~> 5.6.0', require: false
  gem 'rubocop-rails', '~> 2.4.1', require: false
  gem 'spring', '~> 2.1.0'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rspec-json_expectations', '~> 2.2.0'
  gem 'shoulda-matchers', '~> 4.2.0'
  gem 'simplecov', '~> 0.17.1'
  gem 'webmock', '~> 3.8.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
