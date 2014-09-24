class CreateYards < ActiveRecord::Migration
  def change
    create_table :yards do |t|
      t.belongs_to :user
      
      t.string :name
      t.string :slope
      t.string :soil
      t.string :grass
      t.string :sprinkler
      t.string :sprinkler_flow
      t.string :day

      t.timestamps
    end

  end
end
