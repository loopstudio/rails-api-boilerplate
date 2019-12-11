ActionMailer::Base.smtp_settings = {
  domain: ENV.fetch('DOMAIN'),
  address: 'smtp.sendgrid.net',
  port: 465,
  authentication: :plain,
  user_name: 'apikey',
  password: ENV.fetch('SENDGRID_API_KEY'),
  enable_starttls_auto: true
}
