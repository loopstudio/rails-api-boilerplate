source 'https://rubygems.org'
ruby '2.7.2'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'rails', '~> 6.0.3'

# WebServer
gem 'puma', '~> 5.0'
gem 'rack', '~> 2.2.3'
gem 'rack-cors', '~> 1.1.1'

# Database
gem 'pg', '~> 1.2.3'
gem 'strong_migrations', '~> 0.7.2'

# Environment variables
gem 'dotenv-rails', '~> 2.7.6'

# Async worker
gem 'sidekiq', '~> 6.1.2'

# Nullify blank strings before saving to db
gem 'nilify_blanks', '~> 1.4'

# Backoffice
gem 'activeadmin', '~> 2.8.1'
gem 'activeadmin_addons', '~> 1.7.1'
gem 'active_admin_theme', '~> 1.1'
gem 'chartkick', '~> 3.4.2'
gem 'groupdate', '~> 5.2.1'
gem 'ransack', '~> 2.3.2'

# Authentication
gem 'devise', '~> 4.7.3'
gem 'devise_token_auth', '~> 1.1.4'

# Serializing json views
gem 'jb', '~> 0.8.0'

# Pagination
gem 'pagy', '~> 3.9'

# Monitoring errors
gem 'sentry-raven', '~> 3.1.1'

group :development, :test do
  gem 'bullet', '~> 6.1.0'
  gem 'byebug', '>= 11.0.1', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.1.0'
  gem 'faker', '~> 2.15.1'
  gem 'rspec-rails', '~> 4.0.1'
end

group :development do
  gem 'annotate', '~> 3.1.1'
  gem 'letter_opener', '~> 1.7.0'
  gem 'listen', '>= 3.0.5', '< 3.4'
  gem 'reek', '~> 6.0.2', require: false
  gem 'rubocop', '~> 1.3.1', require: false
  gem 'rubocop-rails', '~> 2.8.1', require: false
  gem 'rubocop-rspec', '~> 2.0.0', require: false
  gem 'spring', '~> 2.1.1'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rspec-json_expectations', '~> 2.2.0'
  gem 'shoulda-matchers', '~> 4.4.1'
  gem 'simplecov', '~> 0.19.1'
  gem 'webmock', '~> 3.10.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
