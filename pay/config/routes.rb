Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root to: "visitor#index"

  resource :user_simulateion, only: %i(create destroy)

  devise_for :user, controllers: {
    sessions: "user/sessions"}

  devise_scope :user do
    post "users/sessions/verify" => "Users::SessionsController"
  end

  resources :events
  resources :shopping_cart
  resources :subscription_cart
  resources :payment
  resources :users
  resources :plans
  resources :subscriptions
  resources :refund

  get "paypal/approved", to: "pay_pal_payments#approved"

  post "stripe/webhook", to: "stripe_webhook#action"

end

