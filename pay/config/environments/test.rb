Rails.application.configure do

  config.cache_clases = true

  config.eager_load = false

  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    "Cache-Control" => "public, max-age=3600"}

  config.consider_all_requests_local = true
  conifg.action_controller.perform_caching = false

  config.action_dispatch.show_exceptions = false

  config.action_controller.allow_forgery_protection = false
  config.action_mailer.perform_caching = false

  config.action_mailer.delivery_method = :test

  config.active_support.deprecatoin = :stderr
  #config.action_veiw.raise_on_missing_transactions = true
  #
end

