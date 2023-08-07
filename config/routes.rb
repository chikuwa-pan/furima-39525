Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources :items do
    resources :purchases, only: [:index, :create]
  end
  get '/purchases', to: 'purchases#index'
  get '/category/:id', to: 'items#search'
end
