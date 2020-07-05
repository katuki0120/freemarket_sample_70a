Rails.application.routes.draw do
  devise_for :users
  root "index#index"
  resources :purchase, only: [:index]
  resources :logout, only: [:index]
  resources :creditcard, only:[:index, :new, :create]
  resources :mypages, only: [:index]
  resources :item_page, only: [:index]
  resources :comp_reg, only: [:index]
  resources :products, only: [:index, :new]
  resources :sign_up, only: [:index]
  resources :login, only: [:index]
end
