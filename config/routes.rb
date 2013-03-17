Cashflow::Application.routes.draw do

  mount StripeEvent::Engine => '/stripe'

  get "dashboard" => 'dashboard#index', :as => 'dashboard'

  resources :subscriptions
  get 'my-subscriptions' => 'subscriptions#customer_index', :as => 'my_subscriptions'
  get 'subscription-signup/:token' => 'subscriptions#signup', :as => 'subscription_signup'
  put 'subscription-signup/:token/complete' => 'subscriptions#complete_signup', :as => 'complete_subscription_signup'

  resources :plans
  resources :users

  authenticated :user do
    root :to => 'dashboard#index'
  end

  root :to => "home#index"

  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => 'register'}, :controllers => { :registrations => 'registrations' }
  get 'my-account' => 'users#my_account', :as => 'my_account'
  put 'my-account' => 'users#update_my_account', :as => 'update_my_account'
  
end