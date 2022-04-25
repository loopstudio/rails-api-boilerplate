require 'sidekiq/web'

if Rails.env.production?
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(
      ::Digest::SHA256.hexdigest(username),
      ::Digest::SHA256.hexdigest(ENV.fetch('JOB_MONITOR_USERNAME', 'admin'))
    ) & ActiveSupport::SecurityUtils.secure_compare(
      ::Digest::SHA256.hexdigest(password),
      ::Digest::SHA256.hexdigest(ENV.fetch('JOB_MONITOR_PASSWORD', 'admin'))
    )
  end
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', nil) }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', nil) }
end
