class DashboardController < ApplicationController
  before_filter :authenticate_user!
  # before_filter :authorize_as_admin

  def index
    if current_user.is? :admin
      subscriptions = Subscription.where :active => true

      @total = 0
      subscriptions.each do |subscription|
        @total += subscription.plan.amount
      end

      render 'dashboard/index'
    else
      @subscription_count = current_user.subscriptions.count
      render 'dashboard/customer_index'
    end  

  end

end