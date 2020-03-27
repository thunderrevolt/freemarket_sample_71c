Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root 'products#index'

  resources :buies, only: :index
  resources :products, only: [:new, :create, :show ] do
    resources :comments, only: :create
  end
  resources :users, only: [:index, :show]
  get '/logout', to: 'users#logout'
end
