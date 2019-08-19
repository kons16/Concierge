Rails.application.routes.draw do
  devise_for :users
  resources :users

  root 'home#index'
  get 'home/show'
  get 'users/show'
  post 'users/add_hoby'
  post 'users/delete_hoby'
  post 'users/chat_request'
  get 'users/index'
  get 'users/show'
end
