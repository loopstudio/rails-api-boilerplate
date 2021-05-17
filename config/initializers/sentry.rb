Sentry.init do |config|
  config.dsn = ENV.fetch('SENTRY_DSN')
  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  # Set tracesSampleRate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production
  config.traces_sample_rate = 1
  # or
  config.traces_sampler = lambda do |_context|
    true
  end
  config.async = ->(event) { SentryJob.perform_later(event) }

  filter = ActiveSupport::ParameterFilter.new(Rails.application.config.filter_parameters)
  config.before_send = lambda do |event, hint|
    filter.filter(event.to_hash)
  end
end
