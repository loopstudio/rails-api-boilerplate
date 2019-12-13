Raven.configure do |config|
  config.environments = %w[staging production]
  config.dsn = ENV['SENTRY_DSN']
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
end
