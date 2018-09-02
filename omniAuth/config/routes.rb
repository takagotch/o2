Rails.application.routes.draw do
  get '/auth/:provider/callback' => 'sessions#create'

  root 'home#index'
  get "home/index"
  get '/auth/:provider/callback', :to => 'session#callback'
  post '/auth/:provider/callback', "to => 'session#callback'
  get '/logout' => 'sessions#destroy', :as => :logout

  root :to => "tweet#input"
  get "tweet/input"
  post "tweet/input"
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy"
end

