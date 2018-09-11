require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module SnowGlobe

  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :rspec,
	      fixtures: true,
	      view_spec: false,
	      helper_spec: false,
	      routing_spec: false,
	      controller_specs: false,
	      request_spec: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end

    config.active_job.queue_adapter = :delayed_job


  end

end


