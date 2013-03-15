class SubscriptionsController < ApplicationController

  before_filter :authenticate_user!, :except => [:signup, :complete_signup]
  before_filter :authorize_as_admin, :except => [:signup, :complete_signup, :customer_index, :destroy]

  def signup
    if user_signed_in?
      flash[:error] = "You must be logged out before completing a signup"
      redirect_to root_path
    end

    @subscription = Subscription.find_by_token params[:token]
    @stripe_publishable_key = ENV['STRIPE_PUBLIC_KEY']

    if @subscription.nil? or @subscription.user.nil? or @subscription.plan.nil?
      redirect_to root_path, :alert => "No such signup page found"
    end
  end

  def complete_signup
    @subscription = Subscription.find_by_token params[:token]
    
    if @subscription.complete_signup params[:subscription]
      sign_in(:user, @subscription.user)
      redirect_to my_subscriptions_path, :notice => "Successfully signed up.  We'll send you an email confirmation."
    else
      sign_in(:user, @subscription.user)
      redirect_to my_subscriptions_path, :alert => "There was an error signing up."
    end
  end

  def index
    @subscriptions = Subscription.all
  end

  def customer_index
    @subscriptions = current_user.subscriptions
  end

 def edit
    @subscription = Subscription.find(params[:id])
  end

  def create
    @subscription = Subscription.new params[:subscription]
    @subscription.generate_token
    if @subscription.save
      redirect_to subscriptions_path, :notice => "Subscription created. Email request sent."
    else
      flash[:alert] = "Unable to create subscription"
      render action: "new"
    end
  end

  def new
    @subscription = Subscription.new
    @subscription.user = User.new
    @subscription.plan = Plan.new
  end

  def destroy
    @subscription = Subscription.find(params[:id])

    unless current_user.is? :admin or current_user.id == @subscription.user.id
      redirect_to root_path, :alert => "You are not authorized"
    end
    
    if @subscription.destroy_with_stripe
      if current_user.is? :admin
        redirect_to subscriptions_path, :notice => 'Subscription deleted'
      else
        redirect_to my_subscriptions_path, :notice => 'Subscription deleted'
      end
    else
      render action: "edit"
    end
  end

  def update
    @subscription = Subscription.find(params[:id])

    if @subscription.update_with_stripe params[:subscription]
      redirect_to subscriptions_path, :notice => "Subscription updated"
    else
      render action: "edit"
    end
  end

end