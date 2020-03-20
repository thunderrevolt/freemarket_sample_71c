Rails.application.routes.draw do
  devise_for :users
  root 'products#index'
  get '/index', to: 'users#index'

  resources :products, only: [:new, :create ]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
