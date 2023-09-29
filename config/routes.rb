Rails.application.routes.draw do
  resources :bills, only: [:index, :show, :create]
  resources :products
  root to: 'bills#index'
end
