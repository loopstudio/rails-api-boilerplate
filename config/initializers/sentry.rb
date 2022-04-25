Sentry.init do |config|
  config.dsn = ENV.fetch('SENTRY_DSN', nil)
  config.breadcrumbs_logger = %i[active_support_logger http_logger]
  config.send_default_pii = true
  config.sample_rate = 1.0
  config.async = ->(event) { Sentry::SendEventJob.perform_later(event) }

  # Param filtering
  filter = ActiveSupport::ParameterFilter.new(Rails.application.config.filter_parameters)
  config.before_send = lambda do |event, _hint|
    filter.filter(event.to_hash)
  end
end
