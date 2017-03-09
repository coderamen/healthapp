Rails.application.routes.draw do

get "welcome/index"

get "/auth/:provider/callback" => "sessions#create_from_omniauth"


root "welcome#index"
end
