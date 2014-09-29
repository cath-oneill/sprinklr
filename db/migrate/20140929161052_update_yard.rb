class UpdateYard < ActiveRecord::Migration
  def change
    add_column :yards, :sprinkler_flow_minutes, :integer
    add_column :yards, :sprinkler_flow_inches, :float
  end

  def up
    change_column :yards, :sprinkler_flow, :float
  end

  def down
    change_column :yards, :sprinkler_flow, :string
  end
end
