
config.middleware.insert_before 0, Rack::Cors do
  allow do
    origin '*'
    resource '*', :headers => :any, :methods => [:get, :post, :options]
  end
end


