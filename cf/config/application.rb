config.x.payment_processing.schedule = :daily
config.x.payment_processing.retries = 3
config.super_debugger = true

Rails.configuration.x.payment_processing.schedule
Rails.configuration.x.payment_processing.retries
Rails.configuration.x.payment_processing.not_set
Rails.configuration.super_debugger



module MyApp
  class Application < Rails::Application
    config.payment = config_for(:payment)
  end
end

Rails.configuration.payment['merchant_id']



