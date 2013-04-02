class CreateVictoryFrameworks < ActiveRecord::Migration
  def change
    create_table :victory_frameworks do |t|
      t.string :title
      t.integer :price
      t.string :name

      t.timestamps
    end
  end
end
