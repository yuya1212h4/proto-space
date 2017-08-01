Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'prototypes#index'
  namespace :prototypes do
    resources :popular, only: :index
  end
  resources :prototypes, except: :index do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: :create
  end
  resources :users, only: [:show, :edit, :update]
end
