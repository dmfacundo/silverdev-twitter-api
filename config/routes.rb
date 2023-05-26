Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts, only: [:create]
      get "/feed", to: "posts#feed"
      resources :accounts, only: [:create]
    end
  end
end
