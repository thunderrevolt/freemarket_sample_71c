Rails.application.routes.draw do
  root 'products#index'
  get "/new", to: "products#new"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
