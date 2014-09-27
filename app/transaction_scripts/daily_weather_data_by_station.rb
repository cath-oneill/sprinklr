class DailyWeatherDataByStation
  def self.run(station_id, query = "yesterday") #alternately put in history_YYYYMMDD    
    sta = WeatherStation.find(station_id)
    if sta.bad_data
      puts "Station #{station_id} #{sta.code} #{sta.name} is marked with BAD DATA.  Not pulling information."
      return
    end

    if sta.kind == 'airport'
      url = "http://api.wunderground.com/api/#{ENV["WUNDERGROUND_KEY"]}/#{query}/q/#{sta.code}.json"
    elsif sta.kind = 'pws'
      url = "http://api.wunderground.com/api/#{ENV["WUNDERGROUND_KEY"]}/#{query}/q/pws:#{sta.code}.json"
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
      puts "Station #{station_id} #{sta.code} #{sta.name} -- Data has been downloaded from API and stored."
    end

    unless EtoCalculation.find_by(weather_station_id: sta.id, date: date)
      Evapotranspiration.run(sta.id, date)
      puts "Station #{station_id} #{sta.code} #{sta.name} -- ETO has been calculated and stored."
    end
  end
end