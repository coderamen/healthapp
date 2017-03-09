Rails.application.routes.draw do

get "/auth/:provider/callback" => "sessions#create_from_omniauth"


root "welcome#index"

  # routes for user
  resources :users

  # routes for sessions
  get "/session/new" => "sessions#new", as: "sign_in"
  post "/sessions" => "sessions#create"
  delete "sessions" => "sessions#destroy", as: "sign_out"

  # route for facebook callback, for when the user has already signed_in from fb and are returning from fb
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  # these are routes from clearance
  # resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  # resource :session, controller: "clearance/sessions", only: [:create]

  # resources :users, controller: "clearance/users", only: [:create] do
  #   resource :password,
  #     controller: "clearance/passwords",
  #     only: [:create, :edit, :update]
  # end

  # get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  # delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  # get "/sign_up" => "clearance/users#new", as: "sign_up"
end
