class AddStripeTokenToVictoryPurchases < ActiveRecord::Migration
  def change
    add_column :victory_purchases, :stripe_token, :string
  end
end
