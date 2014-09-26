require_relative '../../app/transaction_scripts/lookup_weather_stations.rb'

namespace :weather_data do
  task :lookup_stations => :environment do
    LookupWeatherStations.run
    puts 'I finished looking up the stations and sticking new ones in the DB!'
  end

  task :get_solar_data => :environment do
    GetSolarData.run
    puts "Done putting solar data in the DB!"
  end
  
  task :get_weather_data => :environment do
    DailyWeatherData.run
    puts "Got some weather data info!"
  end

  task :update_all_closest_stations => :environment do
    UpdateAllClosestStations.run
    puts 'Done updating stations.'
  end

  task :daily => [:get_weather_data, :get_solar_data]
  task :weekly => [:lookup_stations, :update_all_closest_stations]
end