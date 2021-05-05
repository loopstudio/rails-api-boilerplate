require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
require 'rails/test_unit/railtie'

Bundler.require(*Rails.groups)

module RailsApiBoilerplate
  class Application < Rails::Application
    config.load_defaults 6.0

    config.active_job.queue_adapter = :sidekiq
    config.time_zone = ENV.fetch('TZ', 'Eastern Time (US & Canada)')
    config.active_record.default_timezone = :utc

    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
      address: 'smtp.sendgrid.net',
      port: 25,
      domain: ENV['MAILER_DOMAIN'],
      authentication: :plain,
      user_name: 'apikey',
      password: ENV['SENDGRID_API_KEY'],
      enable_starttls_auto: true
    }

    config.action_mailer.default_url_options = { host: ENV['SERVER_URL'] }
    config.action_mailer.default_options = {
      from: ENV.fetch('DEFAULT_FROM_EMAIL_ADDRESS'),
      reply_to: ENV.fetch('DEFAULT_FROM_EMAIL_ADDRESS')
    }

    config.generators do |gen|
      gen.test_framework :rspec
      gen.fixture_replacement :factory_bot, dir: 'spec/factories'
    end
  end
end
