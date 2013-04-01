class VictoryController < ApplicationController
  layout 'victory'

  def index
    @victory_purchase = VictoryPurchase.new
    @stripe_publishable_key = ENV['STRIPE_PUBLIC_KEY']
  end

  def complete
    logger.debug '=====  Params'
    logger.debug params.inspect

    @victory_purchase = VictoryPurchase.new params[:victory_purchase]
    
    if @victory_purchase.complete
      redirect_to victory_purchase_complete_path(@victory_purchase.token), :notice => "Payment processed successfully."
    else
      redirect_to victory_path, :alert => "There was an error signing up."
    end
  end

  def purchase_complete
    @victory_purchase = VictoryPurchase.find_by_token params[:token]
  end
end