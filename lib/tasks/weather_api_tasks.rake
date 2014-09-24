require_relative '../../app/transaction_scripts/lookup_weather_stations.rb'

namespace :weather do
  task :lookup_stations => :environment do
    LookupWeatherStations.run
    puts 'I finished looking up the stations and sticking them in the DB!'
  end

  task :get_weather_data do
    puts "Get some weather data info!"
  end

  task :all => [:lookup_stations, :get_weather_data]
end