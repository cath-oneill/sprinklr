require 'net/http'
require 'json'

class DailyWeatherData
  def self.run(query = "yesterday") #alternately put in history_YYYYMMDD
    weather_stations = WeatherStation.where(bad_data: false)

    weather_stations.each do |sta|
      DailyWeatherWorker.perform_async(sta.id, query)
    end

  end

end