Rails.application.routes.draw do
  resources :quotes
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "pages#index"
  get "residential" => "pages#residential"
  get "commercial" => "pages#commercial"
  get "quotes" => "pages#quote"

  get "/index" => "pages#index"

  # /quotes is the action from the form in quote.html.erb
  post "/quotes" => "quotes#create"
end
