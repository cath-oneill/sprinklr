class ChangeUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :formatted_address, :string
    remove_column :users, :state, :string
  end
end
