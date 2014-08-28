Rails.application.routes.draw do
  resources :performances

  resources :pledges

  root 'welcome#index'

  resources :campaigns
  resources :users, except: :index
  resources :user_sessions

  get '/users/:user_id/pledges/new' => 'pledges#new'
  post '/pledges' => 'pledges#create'
  get '/users/:user_id/pledges' => 'pledges#index'

  get 'login' => 'user_sessions#new', as: 'login'
  get 'logout' => 'user_sessions#destroy', as: 'logout'



end
