Rails.application.routes.draw do
  # resources :interventions

  # Authenticate user to use intervention
  authenticate :user, ->(user) { user.superadmin_role? or user.employee_role? } do
    get "/interventions" => "interventions#index"
  end
  # get "/interventions" => "interventions#index"
  post "/interventions" => "interventions#create"


  get "/get_buildings/:customer_id", to: "interventions#get_buildings"
  get "/get_batteries/:building_id", to: "interventions#get_batteries"
  get "/get_columns/:battery_id", to: "interventions#get_columns"
  get "/get_elevators/:column_id", to: "interventions#get_elevators"
  
  devise_for :users
  
  resources :quotes
  resources :leads
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # Authenticates Blazer Using Devise
  authenticate :user, ->(user) { user.superadmin_role? } do
    mount Blazer::Engine, at: "blazer"
  end

  # # If Above Doesn't Work Then Uncomment Below:
  # mount Blazer::Engine, at: "blazer"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "pages#index"
  get "residential" => "pages#residential"
  get "commercial" => "pages#commercial"
  get "quotes" => "pages#quote"
  

  get "/index" => "pages#index"

  # /quotes is the action from the form in quote.html.erb
  post "/quotes" => "quotes#create"

  # /leads is the action from the form in index.html.erb
  post "/leads" => "leads#create"

  # match '/watson'     => 'watson#speak', via: :get
  get '/watson/update' => 'watson#speak'
 
   
end
