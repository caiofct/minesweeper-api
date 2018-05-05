Rails.application.routes.draw do
  # Authenticate a user returning it's token using his username and password
  post 'authenticate', to: 'authentication#authenticate'
  post 'sessions', to: 'authentication#authenticate'
  # Creates a user
  resources :users, only: [:create]
  resources :grids, only: [:index, :create, :destroy] do
    resources :squares, only: [:index] do
      collection do
        put ":x/:y/toggle_flag", action: :toggle_flag
        put ":x/:y/explore", action: :explore
      end
    end
  end
end
