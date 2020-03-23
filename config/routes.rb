Rails.application.routes.draw do
  devise_for :users
  root 'products#index'
  get "/new", to: "products#new"
  resources :products, only: [:new, :create ]
  resources :users, only: [:index, :show]
end
