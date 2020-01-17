class ResetPasswordPreview < ActionMailer::Preview
  def reset_password_email
    UserMailer.with(user: FactoryBot.build(:user),
                    new_password: Faker::Internet.password(8))
              .reset_password_email
  end
end
