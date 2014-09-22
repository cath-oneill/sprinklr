class CreateYards < ActiveRecord::Migration
  def change
    create_table :yards do |t|
      t.belongs_to :user
      
      t.string :name
      t.integer :slope
      t.integer :soil
      t.integer :grass
      t.integer :sprinkler

      t.timestamps
    end

    create_table :yards_schedules do |t|
      t.belongs_to :schedule
      t.belongs_to :yard
    end
  end
end
