class StripstarterMailer < ActionMailer::Base

  default from: "'Stripstarter' <#{SS_CONFIG.gmail_address}>"

  def welcome_email(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: "Welcome to Stripstarter!")
  end
  
end