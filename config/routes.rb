require "admin_constraint"
require "sidekiq/web"

Rails.application.routes.draw do
  root "welcome#index"
  get "/search" => "welcome#search", as: "search"

  ########
  # Blog #
  ########

  get "/blog" => redirect( "http://" +
      (Rails.env.production? ? "blog.stripstarter.org" : "blog.dev") 
    ), :as => :blog
  get "/blog/about" => redirect( "http://" +
      (Rails.env.production? ? "blog.stripstarter.org/about" : "blog.dev/about") 
    ), :as => :about

  #############
  # Campaigns #
  #############

  get "/campaigns/search" => "campaigns#search", as: "campaign_search"
  resources :campaigns

  ############
  # Sessions #
  ############

  resources :user_sessions
  get "/login" => "user_sessions#new", as: "login"
  get "/logout" => "user_sessions#destroy", as: "logout"

  ##############
  # Performers #
  ##############

  get "/performers/search" => "performers#search", as: "performer_search"
  get "/performers/:performer_id" => "performers#show"

  #########
  # Users #
  #########

  resources :users, except: :index
  resources :pledgers, controller: "users", type: "Pledger"
  resources :performers, controller: "users", type: "Performer"

  ###########
  # Pledges #
  ###########

  post "/pledges" => "pledges#create"
  get "/users/:user_id/pledges" => "pledges#index"
  get "/checkout" => "checkout#index", as: "checkout"
  get  "/checkout/new_customer" => "checkout#new_customer",
       as: "new_customer"
  post "/checkout/create_customer" => "checkout#create_customer",
       as: "create_customer"
  post "/checkout/confirm_pledge" => "checkout#confirm_pledge",
       as: "confirm_pledge"
  delete "/pledges/:id" => "pledges#destroy"

  ######################
  # Sidekiq Monitoring #
  ######################

  constraints(AdminConstraint) do
    mount Sidekiq::Web => "/sidekiq"
  end

end
