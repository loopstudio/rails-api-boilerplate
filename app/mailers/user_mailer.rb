class UserMailer < ApplicationMailer
  def reset_password_email
    @user = params[:user]
    @new_password = params[:new_password]
    mail(to: @user.email, subject: 'Recover rails-api-boilerplate account')
  end
end
