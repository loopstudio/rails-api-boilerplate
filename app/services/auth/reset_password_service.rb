module Auth
  class ResetPasswordService < ApplicationService
    def initialize(user:)
      @user = user
    end

    def call
      reset_password
    rescue StandardError => e
      errors << e.message
    end

    private

    attr_reader :user

    def reset_password
      new_password = Devise.friendly_token.first(8)
      user.update!(password: new_password, must_change_password: true)
      UserMailer.with(user: user, new_password: new_password)
                .reset_password_email
                .deliver_later
    end
  end
end
