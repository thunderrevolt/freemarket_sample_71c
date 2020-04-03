Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root 'products#index'

  resources :categories, only: [:index, :show]
  resources :products, only: [:show, :new, :edit, :destroy, :create, :update] do
    collection do
      get 'search'
    end
    resources :comments, only: :create
    get "/buy" , to: "creditcards#buy"
    #Ajaxで動くアクションのルートを作成
    collection do
      get 'category_list', defaults: { format: 'json' }
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
  
  resources :users, only: [:index, :show] do
    resources :creditcards, only: [:index, :new, :create, :destroy]
  end
  
  get '/logout', to: 'users#logout'

end
