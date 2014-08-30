Rails.application.routes.draw do
  root 'welcome#index'

  #############
  # Campaigns #
  #############

  resources :campaigns
  get '/campaigns/search' => 'campaigns#search', as: 'campaign_search'

  ############
  # Sessions #
  ############

  resources :user_sessions
  get 'login' => 'user_sessions#new', as: 'login'
  get 'logout' => 'user_sessions#destroy', as: 'logout'

  ##############
  # Performers #
  ##############

  get '/performers/search' => 'performers#search', as: 'performer_search'

  #########
  # Users #
  #########

  resources :users, except: :index
  get '/pledgers/:id' => 'users#show'
  get '/performers/:id' => 'users#show'
  resources :pledgers, controller: "users", type: "Pledger"
  resources :performers, controller: "users", type: "Performer"

  ###########
  # Pledges #
  ###########

  get '/users/:user_id/pledges/new' => 'pledges#new'
  post '/pledges' => 'pledges#create'
  get '/users/:user_id/pledges' => 'pledges#index'


end
