Rails.application.routes.draw do
  require 'sidekiq/web'
  root :to => 'welcome#index'

  get "/auth/:provider/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout
  get "/profile" => "users#show"
  get "/edit" => "users#edit"
  get "/plan" => "recommendations#current"

  resources :users, only: [:update] 
  
  authenticate :user, lambda { |u| u.id == 1 } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
