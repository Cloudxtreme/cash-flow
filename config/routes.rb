RailsStripeMembershipSaas::Application.routes.draw do

  mount StripeEvent::Engine => '/stripe'
  get "content/gold"
  get "content/silver"
  get "content/platinum"

  get "dashboard" => 'dashboard#index', :as => 'dashboard'

  resources :subscriptions
  # get 'subscription-signup/' => 'subscriptions#signup', :as => 'subscription_signup'
  get 'subscription-signup/:token' => 'subscriptions#signup', :as => 'subscription_signup'
  put 'subscription-signup/:token/complete' => 'subscriptions#complete_signup', :as => 'complete_subscription_signup'

  resources :plans
  resources :users

  authenticated :user do
    root :to => 'dashboard#index'
  end
  root :to => "home#index"
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => 'register'}, :controllers => { :registrations => 'registrations' }
  devise_scope :user do
    put 'update_plan', :to => 'registrations#update_plan'
    put 'update_card', :to => 'registrations#update_card'
  end
  
end