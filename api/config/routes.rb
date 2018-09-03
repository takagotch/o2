Rails.application.routes.draw do
  get '/images/:q', to: 'images#index'
end



