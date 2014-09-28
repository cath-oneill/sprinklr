class AddWateringDayToRecommendations < ActiveRecord::Migration
  def change
    add_column :recommendations, :watering_day, :date
  end
end
