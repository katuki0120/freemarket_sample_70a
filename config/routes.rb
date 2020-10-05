Rails.application.routes.draw do
  root "index#index"
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
  end

  
  resources :logout, only: [:index]
  resources :mypages, only: [:index]
  resources :item_page, only: [:index]
  resources :comp_reg, only: [:index]
  
  resources :products, only: [:create, :index, :show, :new, :edit, :destroy] do
    collection do
      get 'get_category_children', defaults: {format: 'json'}
      get 'get_category_grand_children', defaults: {fomat: 'json'}
    end
    member do
      get 'get_category_children', defaults: {format: 'json'}
      get 'get_category_grand_children', defaults: {fomat: 'json'}
    end
  end
  resources :sign_up, only: [:index]
  resources :login, only: [:index]
  resources :users
  resources :creditcard, only:[:index, :new, :show] do
    collection do
      post 'show', to: 'creditcard#show'
      post 'pay', to: 'creditcard#pay'
      post 'delete', to: 'creditcard#delete'
    end
  end
  resources :purchase, only: [:index] do
    collection do
      get 'index', to: 'purchase#index'
      post 'pay', to: 'purchase#pay'
      get 'done', to: 'purchase#done'
    end
  end
end
