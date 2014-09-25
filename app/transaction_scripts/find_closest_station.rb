class FindClosestStation
  def self.run(latitude, longitude, user_id)
    puts "IN NEAREST STATION!"
    nearby_stations = WeatherStation.near("#{latitude}, #{longitude}", 5, order: "distance")
    user = User.find(user_id)
    if closest = nearby_stations.first
      user.weather_station_id = closest.id
      user.save
    end
  end
end