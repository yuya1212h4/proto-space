Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'prototypes#index'
  resources :prototypes, only: [:new, :create, :show, :edit]
  resources :users, only: [:show, :edit, :update]
end
