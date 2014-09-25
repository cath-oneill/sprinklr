require 'net/http'
require 'json'

class DailyWeatherData
  def self.run
    weather_stations = WeatherStation.all

    #select stations near users & always select Bergstrom for fallback
    active_weather_stations = weather_stations.select {|sta| sta.users.length > 0 || sta.code == "KAUS"}

    active_weather_stations.each do |sta|
      if sta.kind == 'airport'
        url = "http://api.wunderground.com/api/#{ENV["WUNDERGROUND_KEY"]}/yesterday/q/#{sta.code}.json"
      elsif sta.kind = 'pws'
        url = "http://api.wunderground.com/api/#{ENV["WUNDERGROUND_KEY"]}/yesterday/q/pws:#{sta.code}.json"
      end
      uri = URI(url)
      data = Net::HTTP.get(uri)
      json = JSON.parse(data)

      date = Date.parse(json['history']['date']['pretty'])
      unless WeatherData.find_by(weather_station_id: sta.id, date: date)
        WeatherData.create(
          weather_station_id: sta.id,
          date: date,
          mean_temperature: json['history']['dailysummary'][0]['meantempm'],
          minimum_temperature: json['history']['dailysummary'][0]['mintempm'],
          maximum_temperature: json['history']['dailysummary'][0]['maxtempm'],
          wind_speed: json['history']['dailysummary'][0]['meanwindspdm'],
          minimum_humidity: json['history']['dailysummary'][0]['minhumidity'],
          maximum_humidity: json['history']['dailysummary'][0]['maxhumidity'],          
          minimum_dewpoint: json['history']['dailysummary'][0]['mindewptm'],
          maximum_dewpoint: json['history']['dailysummary'][0]['maxdewptm'],
          precipitation: json['history']['dailysummary'][0]['precipi'] #only thing in imperial because it's part of final calculations
        )
      end

    end

  end

end