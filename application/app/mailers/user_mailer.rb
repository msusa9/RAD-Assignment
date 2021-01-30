class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.forgot_password.subject
  #
  def forgot_password(user)
    @user = user
    @greeting = "Welcome to rails 2020 assignment"

    mail to: user.email, subject: "forgot password"
  end
end
