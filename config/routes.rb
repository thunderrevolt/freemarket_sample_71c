Rails.application.routes.draw do
  devise_for :users
  root 'products#index'


  resources :categories, only: [:index, :show]

  resources :buies, only: :index

  resources :products, only: [:show, :new, :edit, :destroy, :create] do
    resources :comments, only: :create
    get "/buy" , to: "creditcards#buy"
    #Ajaxで動くアクションのルートを作成
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
  
  resources :users, only: [:index, :show] do
    resources :creditcards, only: [:index, :new, :create, :destroy]
  end
  
  get '/logout', to: 'users#logout'

end
