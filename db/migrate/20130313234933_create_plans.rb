class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :stripe_id
      t.integer :amount
      t.string :interval
      t.string :name

      t.timestamps
    end
  end
end
