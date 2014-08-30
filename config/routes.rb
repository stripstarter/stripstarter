Rails.application.routes.draw do
  root 'welcome#index'
  get '/search' => 'welcome#search', as: 'search'

  #############
  # Campaigns #
  #############

  get '/campaigns/search' => 'campaigns#search', as: 'campaign_search'
  resources :campaigns

  ############
  # Sessions #
  ############

  resources :user_sessions
  get '/login' => 'user_sessions#new', as: 'login'
  get '/logout' => 'user_sessions#destroy', as: 'logout'

  ##############
  # Performers #
  ##############

  get '/performers/search' => 'performers#search', as: 'performer_search'
  get '/performers/:performer_id' => 'performers#show'

  #########
  # Users #
  #########

  resources :users, except: :index
  get '/pledgers/:id' => 'users#show'
  resources :pledgers, controller: "users", type: "Pledger"
  resources :performers, controller: "users", type: "Performer"

  ###########
  # Pledges #
  ###########

  get '/users/:user_id/pledges/new' => 'pledges#new'
  post '/pledges' => 'pledges#create'
  get '/users/:user_id/pledges' => 'pledges#index'


end
