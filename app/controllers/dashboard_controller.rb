class DashboardController < ApplicationController

  def index
    subscriptions = Subscription.where :active => true

    subscriptions.each do |subscription|
      @total += subscription.plan.amount
    end

    if @total.nil?
      @total = 0
    end

    @total
    
  end

end