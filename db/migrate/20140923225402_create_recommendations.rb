class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.belongs_to :yards
      
      t.float :inches
      t.integer :minutes
      t.integer :cycles

      t.timestamps
    end
  end
end
