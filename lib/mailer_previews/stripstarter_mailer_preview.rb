class StripstarterMailerPreview < ActionMailer::Preview
  def welcome_email
    user = User.first
    StripstarterMailer.welcome_email(user)
  end
end
