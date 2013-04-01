class AddTokenToVictoryPurchase < ActiveRecord::Migration
  def change
    add_column :victory_purchases, :token, :string
  end
end
