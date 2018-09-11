Rollbar.configure do |config|
  config.access_token = 
	  Rails.application.secrets.rollbar_server_side_access_token

  config.enabled = false if Rails.env.test? || Rails.env.development?

  config.environment = ENV["ROLLBAR_ENV"] || Rails.env
end


