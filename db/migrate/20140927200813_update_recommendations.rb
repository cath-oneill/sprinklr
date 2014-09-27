class UpdateRecommendations < ActiveRecord::Migration
  def change
    remove_column :recommendations, :inches, :float
    remove_column :recommendations, :minutes, :integer
    remove_column :recommendations, :cycles, :integer

    add_column :recommendations, :weekly_precipitation, :float
    add_column :recommendations, :weekly_eto, :float
    add_column :recommendations, :min_req_water, :float
    add_column :recommendations, :max_req_water, :float
    add_column :recommendations, :min_irrigation, :float
    add_column :recommendations, :max_irrigation, :float
    add_column :recommendations, :min_minutes, :integer
    add_column :recommendations, :max_minutes, :integer
  end
end
