class CreateWeatherReports < ActiveRecord::Migration
  def change
    create_table :weather_reports do |t|
      t.belongs_to :recommendation
      t.belongs_to :weather_data
      t.timestamps
    end
  end
end
