Rails.application.routes.draw do
  # Authenticate a user returning it's token using his username and password
  post 'authenticate', to: 'authentication#authenticate'
  # Creates a user
  resources :users, only: [:create]
  resources :grids, only: [:index, :create, :destroy]
end
