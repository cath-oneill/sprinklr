require 'date'

class UpdateAllClosestStations

  def self.run
    new_stations = WeatherStation.where("created_at >= ?", Time.zone.now.beginning_of_day)
    if new_stations.length > 0
      puts "There are #{new_stations.length} new weather stations."
      users = User.all
      users.each do |u|
        FindClosestStation.run(u.latitude, u.longitude, u.id)
      end
    end
  end

end