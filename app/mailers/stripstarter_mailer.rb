class StripstarterMailer < ActionMailer::Base

  default from: "'Stripstarter' <stripstarter@gmail.com>"

  def welcome_email(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: "Welcome to Stripstarter!")
  end
  
end