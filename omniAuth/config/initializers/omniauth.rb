Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,
    Rails.application.secrets.twitter_api_key,
    Rails.application.secrets.twitter_api_secret

  provider :twitter, Settings.twitter.consumer_key, Settings.twitter.consumer_secret

  provider :twitter, CONSUMER_KEY, CONSUMER_SECRET

end

