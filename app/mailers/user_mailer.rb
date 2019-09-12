class UserMailer < ApplicationMailer
  def reset_password_email
    @user = params[:user]
    @new_password = params[:new_password]
    mail(to: @user.email, subject: I18n.t('emails.reset_password.recover_account'))
  end
end
