namespace :weather do
  task :lookup_stations => :environment do
    LookupWeatherStations.run
    puts 'I finished looking up the stations and sticking new ones in the DB!'
  end

  task :update_all_closest_stations => :environment do
    UpdateAllClosestStations.run
    puts 'Done updating stations.'
  end

  task :get_solar_data => :environment do
    GetSolarData.run
    puts "Done putting solar data in the DB!"
  end
  
  task :get_weather_data => :environment do
    DailyWeatherData.run ##Also runs evapotranspiration -- MUST RUN AFTER SOLAR DATA!
    puts "Got some weather data info and calculated evapotranspiration!"
  end

  #at command line: rake weather:recommendations_by_date[September,26,2014]
  task :recommendations_by_date, [:month, :date, :year] => :environment do |task, args|
    RunAllRecommendations.run("#{args.month} #{args.date}, #{args.year}")
  end

  task :recommendations => :environment do 
    RunAllRecommendations.run
  end

  task :daily => [ :get_solar_data, :get_weather_data]
  task :weekly => [:lookup_stations, :update_all_closest_stations]
end