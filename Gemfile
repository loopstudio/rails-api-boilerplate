source 'https://rubygems.org'
ruby '2.6.0'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise_token_auth', '~> 1.0.0.rc2'
gem 'jb', '~> 0.7.0'
gem 'pg', '~> 0.18.4'
gem 'puma', '~> 3.11'
gem 'rack-cors', '~> 0.4.0'
gem 'rails', '~> 6.0.0.rc1'
gem 'sidekiq', '~> 6.0.0.pre1'

group :development, :test do
  gem 'bullet', '~> 6.0.1'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails', '~> 2.7.4'
  gem 'factory_bot_rails', '~> 5.0.2'
  gem 'faker', '~> 1.9.4'
  gem 'rspec-rails', '~> 3.8.2'
end

group :development do
  gem 'annotate', '~> 2.6.5'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'reek', '~> 5.4.0', require: false
  gem 'rubocop-rails', '~> 2.0.1', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener', '~> 1.7.0'
end

group :test do
  gem 'shoulda-matchers', '~> 4.1.0'
  gem 'simplecov', '~> 0.13.0'
  gem 'webmock', '~> 3.6.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
