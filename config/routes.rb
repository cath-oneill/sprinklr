Rails.application.routes.draw do
  root :to => 'welcome#index'

  get "/auth/:provider/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout
  get "/plan" => "recommendations#current"
  get "/map" => "map#map"
  resource :profile, only: [:show, :edit, :update], :controller => 'users'

  get "/eto/:YYYY/:MM/:DD" => "weather#eto"
end
