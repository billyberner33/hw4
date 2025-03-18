Rails.application.routes.draw do
  # Home page (redirects to places index)
  root to: "places#index"

  # Resourceful routes
  resources :places do
    resources :entries, only: [:new, :create, :index]
  end  
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  # Authentication routes
  get "/signup", to: "users#new", as: "signup"
  post "/users", to: "users#create"
  
  get "/login", to: "sessions#new", as: "login"
  post "/sessions", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
end
