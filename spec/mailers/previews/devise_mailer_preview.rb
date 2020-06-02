class DeviseMailerPreview < ActionMailer::Preview
  def reset_password_instructions
    user = FactoryBot.build(:user)
    token = Faker::Number.number(digits: 6)
    Devise::Mailer.reset_password_instructions(user, token)
  end
end
