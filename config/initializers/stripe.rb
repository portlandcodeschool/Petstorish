Rails.configuration.stripe = {
  :publishable_key => 'pk_test_9iInpCuMfJkwKo7k9PHCAKdS',
  :secret_key      => 'sk_test_fGOPcLBKAOKOUrO8SzmirXtq'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
