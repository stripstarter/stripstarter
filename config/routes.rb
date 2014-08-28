Rails.application.routes.draw do
  resources :performances

  resources :pledges

  root 'welcome#index'

  resources :campaigns
  resources :users, except: :index
  resources :user_sessions

  get 'login' => 'user_sessions#new', as: 'login'
  get 'logout' => 'user_sessions#destroy', as: 'logout'
end
