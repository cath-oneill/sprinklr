class UpdateYards < ActiveRecord::Migration
  def change
    remove_column :yards, :slope, :string
    remove_column :yards, :soil, :string
  end
end
