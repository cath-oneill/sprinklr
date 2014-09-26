Rails.application.routes.draw do

  root :to => 'welcome#index'

  get "/auth/:provider/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout  

  resources :users, except: [:index, :new, :create, :destroy] do
    resources :recommendations, only: [:index, :show]
  end
    
end
