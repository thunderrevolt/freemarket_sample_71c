Rails.application.routes.draw do
  devise_for :users
  root 'products#index'

  resources :products, only: [:new, :create, :show ] do
    resources :comments, only: :create
  end

  resources :users, only: [:index, :show]
  get '/logout', to: 'users#logout'
end
