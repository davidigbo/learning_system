# config/initializers/stripe.rb
if Rails.env.production?
    Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
  else
    Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
  end
  