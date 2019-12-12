ActionMailer::Base.smtp_settings = {
  domain: ENV['MAILER_DOMAIN'],
  address: 'smtp.sendgrid.net',
  port: 465,
  authentication: :plain,
  user_name: 'apikey',
  password: ENV['SENDGRID_API_KEY'],
  enable_starttls_auto: true
}
