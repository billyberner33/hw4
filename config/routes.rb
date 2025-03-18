Rails.application.routes.draw do
  # Home page (redirects to places index)
  root to: "places#index"

  # Resourceful routes
  resources :entries
  resources :places
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  # Authentication routes
  get "/signup", to: "users#new", as: "signup"
  post "/users", to: "users#create"
  
  get "/login", to: "sessions#new", as: "login"
  post "/sessions", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"
end
