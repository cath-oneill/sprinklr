class AddZipsToStations
  def self.run(weather_station_id)
    ws = WeatherStation.find(weather_station_id)
    latitude = ws.latitude
    longitude = ws.longitude
    response = Geocoder.search("#{latitude} #{longitude}")
    if geo = response.first
        ws.zip = geo.postal_code
    end
    ws.save
  end
end