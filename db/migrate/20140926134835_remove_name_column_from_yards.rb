class RemoveNameColumnFromYards < ActiveRecord::Migration
  def change
    remove_column :yards, :name, :string
  end
end
