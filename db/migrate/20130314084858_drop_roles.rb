class DropRoles < ActiveRecord::Migration
  def up
    drop_table :roles
  end

  def down
    create_table(:roles) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end
  end
end
