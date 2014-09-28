class FixRecommendations < ActiveRecord::Migration
  def change
    remove_column :recommendations, :yards_id, :integer
    add_reference :recommendations, :yard, index: true
  end
end
