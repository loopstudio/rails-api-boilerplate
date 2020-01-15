DeviseTokenAuth.setup do |config|
  config.change_headers_on_each_request = false
  config.remove_tokens_after_password_reset = true
  config.token_lifespan = 20.weeks
  config.max_number_of_devices = 5
  config.batch_request_buffer_throttle = 10.seconds
  config.token_cost = Rails.env.test? ? 1 : 8
end
