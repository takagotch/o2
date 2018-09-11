Stripe.api_key = Rails.application.secrets.stripe_secret_key
raise "Missing Stripe API Key" unless defined? STRIPE_JS_HOST
STRIPE_JS_FILE = Rails.development? ? "stripe-debug.js" : ""

