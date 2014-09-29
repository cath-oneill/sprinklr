class FindClosestStation
  def self.run(latitude, longitude, user_id)
    nearby_stations = WeatherStation.near("#{latitude}, #{longitude}", 5, order: "distance")
    return if nearby_stations.nil?
    user = User.find(user_id)
    closest = nearby_stations.first 
    unless closest.bad_data || closest.nil?
      user.weather_station_id = closest.id
      user.save
    end
  end
end