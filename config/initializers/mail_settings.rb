if Rails.env.development? || Rails.env.production?

  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.perform_deliveries = true

  ActionMailer::Base.smtp_settings = {
    address: "smtp.gmail.com",
    port: "587",   # NOTE: upgrade to use 465 for ssl connections
    domain: "stripstarter.org",
    authentication: :plain,
    user_name: SS_CONFIG.gmail_address,
    password: SS_CONFIG.gmail_password
  }
end