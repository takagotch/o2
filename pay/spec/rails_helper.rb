
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
abort("Rails is running in production mode!") if Rails.env.production?
require "spec_helper"
require "rspec/rails"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  
  config.infer_spec_type_from_file_location!
  #  RSpec.describe UsersController, :type => :controller do
  #  end
  config.filter_rails_from_backtrace!
  # config.filter_gems_from_backtrace("gem name")
end


