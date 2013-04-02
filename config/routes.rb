Victorypayment::Application.routes.draw do

  mount StripeEvent::Engine => '/stripe'

  get "dashboard" => 'dashboard#index', :as => 'dashboard'

  resources :subscriptions
  root :to => 'victory_purchases#index', :as => 'root'
  get 'special/:name' => 'victory_purchases#version', :as => 'version'

  post 'complete' => 'victory_purchases#complete', :as => 'victory_purchases_complete'
  get 'receipt/:token' => 'victory_purchases#receipt', :as => 'victory_purchases_receipt'

  resources :plans
  resources :users
  resources :victory_frameworks, :path => 'victory-frameworks'

  authenticated :user do
    root :to => 'dashboard#index'
  end

  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => 'register'}, :controllers => { :registrations => 'registrations' }

  
end