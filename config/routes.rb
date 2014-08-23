Rails.application.routes.draw do
  root 'welcome#index'

  resources :campaigns
  resources :users

  get 'login' => 'user_sessions#new', as: 'login'
  get 'logout' => 'user_sessions#destroy', as: 'logout'
end
