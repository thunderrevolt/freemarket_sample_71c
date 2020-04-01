Rails.application.routes.draw do
  devise_for :users
  root 'products#index'


  resources :categories, only: [:index, :show]

  resources :buies, only: :index

  resources :products, only: [:show, :new, :edit, :destroy, :create, :update] do
    resources :comments, only: :create
    #Ajaxで動くアクションのルートを作成
    collection do
      get 'category_list', defaults: { format: 'json' }
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
  resources :users, only: [:index, :show]
  resources :cards, only: [:index, :new]
  get '/logout', to: 'users#logout'

end
