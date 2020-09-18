require 'active_job'
require 'webmock/rspec'
require 'active_support/testing/time_helpers'

RSpec.configure do |config|
  config.include ActiveJob::TestHelper
  config.include ActiveSupport::Testing::TimeHelpers

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.order = :random

  config.before do
    ActionMailer::Base.deliveries.clear
    ActiveJob::Base.queue_adapter = :test
  end

  config.after do
    FileUtils.rm_rf(Dir[Rails.root.join('/spec/support/uploads').to_s])
  end
end
