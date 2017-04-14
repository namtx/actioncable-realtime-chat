Rails.application.routes.draw do
  devise_for :users
  root 'conversations#index'
  resources :personal_messages, only: [:new, :create]
  resources :conversations, only: [:index, :show]
  resources :users, only: [:index]
  mount ActionCable.server => '/cable'
end
