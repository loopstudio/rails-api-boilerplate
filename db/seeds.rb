# This is not the place for test data
# Only use this to put the necessary setup for the app to work
# Separate the seeds in different Seed Service Objects
# The data can then be loaded with the rails db:seed command

unless AdminUser.count.positive?
  AdminUser.create!(email: 'admin@example.com',
                    password: 'password',
                    password_confirmation: 'password')
end
