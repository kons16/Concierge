Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

  devise_for :users
  resources :users

  root 'home#index'
  get 'home/show'
  get 'users/show'
end
