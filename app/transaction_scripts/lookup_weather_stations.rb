require 'net/http'
require 'json'

class LookupWeatherStations
  def self.run
    url = "http://api.wunderground.com/api/#{ENV["WUNDERGROUND_KEY"]}/geolookup/q/TX/Austin.json"
    uri = URI(url)
    data = Net::HTTP.get(uri)
    json = JSON.parse(data)

    airports = json['location']['nearby_weather_stations']['airport']['station']
    airports.each do |x|
      unless WeatherStation.find_by(code: x['icao'])
        ws = WeatherStation.create(
          latitude: x['lat'],
          longitude: x['lon'],
          code: x['icao'],
          kind: 'airport',
          name: x['city']
          )
        AddZipsToStations.run(ws.id)
      end
    end

    pw_stations = json['location']['nearby_weather_stations']['pws']['station']
    pw_stations.each do |x|
      unless WeatherStation.find_by(code: x['id'])
        ws = WeatherStation.create(
          latitude: x['lat'],
          longitude: x['lon'],
          code: x['id'],
          kind: 'pws',
          name: x['neighborhood']
          )
        AddZipsToStations.run(ws.id)
      end
    end
  end
end