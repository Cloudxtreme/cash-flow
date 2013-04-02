class AddVictoryFrameworkIdToVictoryPurchase < ActiveRecord::Migration
  def change
    add_column :victory_purchases, :victory_framework_id, :integer
  end
end
