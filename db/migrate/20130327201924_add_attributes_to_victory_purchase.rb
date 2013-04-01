class AddAttributesToVictoryPurchase < ActiveRecord::Migration
  def change
    add_column :victory_purchases, :first_name, :string
    add_column :victory_purchases, :last_name, :string
    add_column :victory_purchases, :email, :string
    remove_column :victory_purchases, :user_id
  end
end