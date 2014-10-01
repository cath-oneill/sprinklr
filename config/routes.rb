Rails.application.routes.draw do
  root :to => 'welcome#index'

  get "/auth/:provider/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout
  #get "/profile" => "users#show"
  #get "/edit" => "users#edit"
  get "/plan" => "recommendations#current"
  get "/map" => "welcome#map"
  #put "/update" => "users#update"
  #resources :users, only: [:update]
  resource :profile, only: [:show, :edit, :update], :controller => 'users'
end
