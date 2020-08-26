source 'https://rubygems.org'
ruby '2.7.1'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'rails', '~> 6.0.3'

# WebServer
gem 'puma', '~> 4.3'
gem 'rack', '~> 2.2.3'
gem 'rack-cors', '~> 1.1.1'

# Database
gem 'pg', '~> 1.2.3'

# Environment variables
gem 'dotenv-rails', '~> 2.7.6'

# Async worker
gem 'sidekiq', '~> 6.1.1'

# Nullify blank strings before saving to db
gem 'nilify_blanks', '~> 1.4'

# Backoffice
gem 'activeadmin', '~> 2.7.0'
gem 'activeadmin_addons', '~> 1.7.1'
gem 'active_admin_theme', '~> 1.1'
gem 'ransack', '~> 2.3.2'

# Authentication
gem 'devise', '~> 4.7.2'
gem 'devise_token_auth', '~> 1.1.4'

# Serializing json views
gem 'jb', '~> 0.7.1'

# Pagination
gem 'pagy', '~> 3.8'

# Monitoring errors
gem 'sentry-raven', '~> 3.0.2'

group :development, :test do
  gem 'bullet', '~> 6.1.0'
  gem 'byebug', '>= 11.0.1', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.1.0'
  gem 'faker', '~> 2.13.0'
  gem 'rspec-rails', '~> 4.0.1'
end

group :development do
  gem 'annotate', '~> 3.1.1'
  gem 'letter_opener', '~> 1.7.0'
  gem 'listen', '>= 3.0.5', '< 3.3'
  gem 'reek', '~> 6.0.1', require: false
  gem 'rubocop', '~> 0.89.1', require: false
  gem 'rubocop-rails', '~> 2.7.1', require: false
  gem 'spring', '~> 2.1.0'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rspec-json_expectations', '~> 2.2.0'
  gem 'shoulda-matchers', '~> 4.4.0'
  gem 'simplecov', '~> 0.18.5'
  gem 'webmock', '~> 3.8.3'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
