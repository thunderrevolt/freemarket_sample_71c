Rails.application.routes.draw do
  devise_for :users
  root 'products#index'


  resources :buies, only: :index
  resources :products, only: [:new, :create, :show, :destroy] do
    resources :comments, only: :create
    get "/buy" , to: "creditcards#buy"
  end
  
  resources :users, only: [:index, :show] do
    resources :creditcards, only: [:index, :new, :create, :destroy]
  end
  
  get '/logout', to: 'users#logout'
end
