class SubscriptionsController < ApplicationController

  def signup
    @subscription = Subscription.find_by_token params[:token]
    @stripe_publishable_key = ENV['STRIPE_PUBLIC_KEY']

    if @subscription.nil?
      redirect_to root_path, :alert => "No such signup page found"
    end
  end

  def complete_signup
    @subscription = Subscription.find_by_token params[:token]

    if @subscription.complete_signup params[:subscription]
      redirect_to root_path, :notice => "Successfully signed up.  We'll send you an email confirmation."
    end
  end

  def index
    @subscriptions = Subscription.all
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
    if @subscription.destroy_with_stripe
      redirect_to subscriptions_path, :notice => 'Subscription deleted'
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