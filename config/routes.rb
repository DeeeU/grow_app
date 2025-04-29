Rails.application.routes.draw do
  root 'binary#index'
  resources :binary

  # Authentication routes
  get 'login', to: 'user_sessions#new', as: :login
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy', as: :logout

  # User registration
  resources :users, only: %i[new create]

  # Password reset
  resources :password_resets, only: %i[new create edit update]
  get 'password_resets/reset_dialog', to: 'password_resets#reset_dialog', as: :reset_dialog

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
end
