Sentry.init do |config|
  config.dsn = ENV['SENTRY_DSN']
  config.breadcrumbs_logger = %i[active_support_logger http_logger]
  config.environment = Rails.env
  config.send_default_pii = true
  config.sample_rate = 1.0
  config.async = ->(event) { Sentry::SendEventJob.perform_later(event) }
end
