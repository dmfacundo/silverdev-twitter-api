Rails.application.routes.draw do
  resources :posts, only: [:create]
  resources :accounts, only: [:create]
end
