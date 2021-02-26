Rails.application.routes.draw do
  devise_for :users
  
  resources :quotes
  resources :leads
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Blazer::Engine, at: "blazer"
  #During Production
  # ENV["BLAZER_DATABASE_URL"] = "postgres://user:password@hostname:5432/database"


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

  get "charts" => "pages#quotes_back_office" 
  get "charts" => "pages#elevator_back_office" 
  get "charts" => "pages#contact_back_office" 
end
