Rails.configuration.stripe = {
  publishable_key: SS_CONFIG.stripe_test_publishable_key,
  secret_key:      SS_CONFIG.stripe_test_secret_key
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
