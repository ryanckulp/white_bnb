class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user
    mail(to: user.email, subject: "Welcome to #{Rails.application.credentials.company_name}!")
  end
end
