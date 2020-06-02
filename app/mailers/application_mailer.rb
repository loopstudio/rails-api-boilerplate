class ApplicationMailer < ActionMailer::Base
  default from: ENV['DEFAULT_FROM_EMAIL_ADDRESS'], reply_to: ENV['DEFAULT_FROM_EMAIL_ADDRESS']
  layout 'mailer'
end
