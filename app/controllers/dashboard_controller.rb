class DashboardController < ApplicationController
  before_filter :authenticate_user!
  # before_filter :authorize_as_admin

  def index
    @victory_frameworks = VictoryFramework.all

    if current_user.is? :admin

      @total = 0
      VictoryPurchase.all.each do |victory_purchase|
        @total += victory_purchase.victory_framework.price
      end

      render 'dashboard/index'
    else
      @subscription_count = current_user.subscriptions.count
      render 'dashboard/customer_index'
    end  

  end

end