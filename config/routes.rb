Rails.application.routes.draw do
  devise_for :users
  root 'products#index'
  get "/new", to: "products#new"
  resources :products, only: [:create ]
  resources :users, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
