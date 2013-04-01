Victorypayment::Application.routes.draw do

  mount StripeEvent::Engine => '/stripe'

  get "dashboard" => 'dashboard#index', :as => 'dashboard'

  resources :subscriptions
  root :to => 'victory_purchase#index', :as => 'root'

  post 'complete' => 'victory_purchase#complete', :as => 'victory_purchase_complete'
  get 'receipt/:token' => 'victory_purchase#receipt', :as => 'victory_purchase_receipt'

  resources :plans
  resources :users

  authenticated :user do
    root :to => 'dashboard#index'
  end

  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => 'register'}, :controllers => { :registrations => 'registrations' }

  
end