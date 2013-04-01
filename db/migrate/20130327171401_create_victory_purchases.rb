class CreateVictoryPurchases < ActiveRecord::Migration
  def change
    create_table :victory_purchases do |t|
      t.integer :user_id
      t.string :stripe_charge_id
      t.integer :last_4
      t.string :license_key

      t.timestamps
    end
  end
end
