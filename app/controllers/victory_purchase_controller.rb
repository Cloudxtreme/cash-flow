class VictoryPurchaseController < ApplicationController
  layout 'victory'

  def index
    @victory_purchase = VictoryPurchase.new
    @stripe_publishable_key = ENV['STRIPE_PUBLIC_KEY']
  end

  def complete

    @victory_purchase = VictoryPurchase.new params[:victory_purchase]
    
    if @victory_purchase.complete
      redirect_to victory_purchase_receipt_path(@victory_purchase.token), :notice => "Payment processed successfully."
    else
      redirect_to victory_path, :alert => "There was an error signing up."
    end
  end

  def receipt
    @victory_purchase = VictoryPurchase.find_by_token params[:token]
  end
end