require 'net/http'
require 'json'

class DailyWeatherData
  def self.run(query = "yesterday") #alternately put in history_YYYYMMDD
    weather_stations = WeatherStation.where(bad_data: false)
    timer = 1
    weather_stations.each do |sta|
      timer += 1
      DailyWeatherWorker.perform_in(timer.minutes, sta.id, query)
    end

  end

end