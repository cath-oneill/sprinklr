Rails.application.routes.draw do
  require 'sidekiq/web'
  root :to => 'welcome#index'

  get "/auth/:provider/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout
  get "/profile" => "users#show"
  get "/edit" => "users#edit"
  get "/plan" => "recommendations#current"

  resources :users, only: [:update] 

  if current_user.login_email == 'cathzozo@gmail.com' || current.login_email = "seanoneillut@gmail.com"
    mount Sidekiq::Web => '/sidekiq' 
  end
end
