class AddWeatherStationRefToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :weather_station, index: true
  end
end
