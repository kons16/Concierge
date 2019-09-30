Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users/registrations" }
  resources :users, only: [:index, :create, :new]
  resources :users, only: [:show, :edit, :update, :destroy, :add_hoby], param: :search_id
  resource :rooms

  root 'home#index'
  get 'home/show'
  post 'home/reject'
  post 'home/create_room'

  post 'rooms/report_user'
  post 'rooms/end_chat'

  get 'users/show'
  post 'users/add_hoby'
  post 'users/delete_hoby'
  post 'users/chat_request'
  get 'users/index'
  get 'users/show'
  post 'users/delete_icon'
end
