module Auth
  class ResetPasswordService < ApplicationService
    def initialize(user)
      @user = user
    end

    def call
      new_password = Devise.friendly_token.first(8)
      user.update!(password: new_password, must_change_password: true)
      ::UserMailer.reset_password_email(user, new_password).deliver_later
    end

    private

    attr_reader :user
  end
end
