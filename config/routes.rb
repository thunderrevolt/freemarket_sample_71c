Rails.application.routes.draw do
  devise_for :users
  root 'products#index'

  resources :products, only: [:new, :create, :show ] do
    resources :comments, only: :create
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/new", to: "products#new"

  resources :products, only: [:new, :create ]
  resources :users, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
