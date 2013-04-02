class VictoryPurchasesController < ApplicationController
  layout 'victory'

  def index
    @victory_purchase = VictoryPurchase.new
    @victory_purchase.victory_framework = VictoryFramework.find_by_name 'main'
    @stripe_publishable_key = ENV['STRIPE_PUBLIC_KEY']
  end

  def version
    @victory_purchase = VictoryPurchase.new
    @victory_purchase.victory_framework = VictoryFramework.find_by_name params[:name]

    if @victory_purchase.victory_framework.nil?
      redirect_to root_path
    end
    @stripe_publishable_key = ENV['STRIPE_PUBLIC_KEY']

    render 'victory_purchases/index'
  end

  def complete
    @victory_framework = VictoryFramework.find_by_name params[:victory_purchase][:victory_framework_name]
    params[:victory_purchase].delete :victory_framework_name

    @victory_purchase = VictoryPurchase.new params[:victory_purchase]
    @victory_purchase.victory_framework = @victory_framework

    if @victory_purchase.complete
      redirect_to victory_purchases_receipt_path(@victory_purchase.token), :notice => "Payment processed successfully."
    else
      redirect_to victory_path, :alert => "There was an error signing up."
    end
  end

  def receipt
    @victory_purchase = VictoryPurchase.find_by_token params[:token]
  end
end