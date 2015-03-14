require 'api'

Venuedog::Application.routes.draw do

  ################ Admin and Profile
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  mount Venuedog::API => "/"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  match '/profile', :to => 'calendar_events#users_profile'
  match '/profile/my-event-listings', :to => 'calendar_events#users_events'
  match '/profile/add_event_to_calendar/:event_id', :to => 'calendar_events#create', :as => :add_event_to_calendar
  match '/profile/my-calendar', :to => 'calendar_events#users_calendar'
  get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  match '/system/send_contact_form', :to => 'pages#email_contact'
  match '/error', :to => 'application#render_404'


  ################ Cities -> Events, Venues, Categories

  ######### Events
  match '/events/share_event_email', :to => 'events#share_event_email'
  match '/:city_id' => "cities#show", :as => :city
  match '/:city_id/events', :to => "events#index", :as => :events
  match '/:city_id/events/new', :to => "events#new", :as => :new_event
  match '/:city_id/events/create', :to => "events#create", :as => :create_event
  match '/:city_id/events/:id/edit', :to => "events#edit", :as => :edit_event
  match '/:city_id/events/:id/update', :to => "events#update", :as => :update_event
  match '/:city_id/events/:id', :to => "events#show", :as => :event, :via => :get
  match '/:city_id/events/:id', :to => "events#destroy", :as => :event, :via => :delete
  match '/events-per-day/:city_id/:year/:month/events-per-day', :to => 'events#events_per_day'
  match '/:city_id/show-by-date/:date', :to => 'events#show_by_date'
  match '/:city_id/events/:id/success', :to => 'events#success', :as => :event_success

  ######### City 101
  match '/:city_id/city-101', :to => 'city101s#show', :as => :city_101

  ######### Venues
  match '/:city_id/venues', :to => 'venues#index', :as => :venues 
  match '/:city_id/venues/new', :to => 'venues#new', :as => :new_venue
  match '/:city_id/venues/create', :to => 'venues#create', :as => :create_venue
  match '/:city_id/venues/:id/edit', :to => 'venues#edit', :as => :edit_venue
  match '/:city_id/venues/:id/update', :to => 'venues#update', :as => :update_venue
  match '/:city_id/venues/:id/success', :to => 'venues#success', :as => :venue_success
  match '/:city_id/venues/:id', :to => 'venues#show', :as => :venue, :via => :get
  match '/:city_id/venues/:id', :to => 'venues#destroy', :as => :venue, :via => :delete
  match "/:city_id/venues/:id/all-events", :to => 'venues#all_events', :as => :all_events_at_venue


  ######### Categories
  match '/:city_id/categories', :to => "categories#index", :as => :categories
  match '/:city_id/categories/new', :to => "categories#new", :as => :new_category
  match '/:city_id/categories/:id', :to => "categories#show", :as => :category
  match '/:city_id/categories/:id/edit', :to => "categories#edit", :as => :edit_category

  ######### Other
  match '/pages/contact-us', :to => 'pages#contact_us', :defaults => {:page_name => 'Contact Us' }
  match '/pages/:page_id' => 'pages#show', :as => :page
  match '/:city_id/search', :to => 'events#search', :as => :search

  resources :labels
  resources :calendar_events
  resources :venue_categories
  match "/calendar_events/:id/reminder" => "calendar_events#reminder", :via => :get

  root :to => 'pages#homepage'


  get '/robots.txt' => 'pages#robots'

end
