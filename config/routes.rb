Rails.application.routes.draw do
  devise_for :users
  resources :products do
    resources :pictures
  end
  get 'products/index'
  
  root 'products#index'

end
