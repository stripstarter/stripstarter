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

  resources :campaigns
  get "/campaigns/search" => "campaigns#search", as: "campaign_search"
  get "/campaigns/:id/finish" => "campaigns#finish", as: "campaign_finish"
  post "/campaigns/:id/submit" => "campaigns#submit", as: "campaign_submit"

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
  get  "/checkout/new_customer" => "checkout#new_customer", as: "new_customer"
  post "/checkout/create_customer" => "checkout#create_customer", as: "create_customer"
  post "/checkout/confirm_pledge" => "checkout#confirm_pledge", as: "confirm_pledge"
  delete "/pledges/:id" => "pledges#destroy"

  ##########
  # Photos #
  ##########

  post "/photos" => "photos#create", as: "photos"
  get "/photos/:photo_id" => "photos#show", as: "photo"
  delete "/photos/:photo_id" => "photos#destroy", as: "photo_destroy" # fix

  #########
  # Admin #
  #########

  get "/admin/campaigns" => "admin#campaigns", as: "admin_campaigns"
  post "/admin/:campaign_id/approve" => "admin#approve", as: "admin_approve"
  post "/admin/:campaign_id/deny" => "admin#deny", as: "admin_deny"
  post "/admin/:campaign_id/cancel" => "admin#cancel", as: "admin_cancel"

  ######################
  # Sidekiq Monitoring #
  ######################

  constraints(AdminConstraint) do
    mount Sidekiq::Web => "/sidekiq"
  end

end
