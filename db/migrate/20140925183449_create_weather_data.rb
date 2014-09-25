class CreateWeatherData < ActiveRecord::Migration
  def change
    create_table :weather_data do |t|
      t.belongs_to :weather_station
      t.date :date
      t.float :mean_temperature
      t.float :minimum_temperature
      t.float :maximum_temperature
      t.float :wind_speed
      t.float :minimum_humidity
      t.float :maximum_humidity
      t.float :minimum_dewpoint
      t.float :maximum_dewpoint
      t.float :precipitation

      t.timestamps
    end
  end
end
