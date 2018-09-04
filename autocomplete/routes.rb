resources :users do
  member do
    get :following, :followers
  end
  collection do
    get :auto_complete
  end
end

