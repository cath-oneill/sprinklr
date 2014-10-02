namespace :weather do
  task :lookup_stations => :environment do
    LookupWeatherStations.run
    puts 'I finished looking up the stations and sticking new ones in the DB!'
  end

  task :update_all_closest_stations => :environment do
    UpdateAllClosestStations.run
    puts 'Done updating stations.'
  end

  task :add_zips_to_all_stations => :environment do
    WeatherStation.all.each { |ws| AddZipsToStations.run(ws.id) }
  end

  task :get_solar_data => :environment do
    GetSolarData.run
    puts "Done putting solar data in the DB!"
  end
  
  task :get_weather_data => :environment do
    DailyWeatherData.run ##Also runs evapotranspiration -- MUST RUN AFTER SOLAR DATA!
    puts "Got some weather data info and calculated evapotranspiration!"
  end

  task :get_weather_data_by_date, [:YYYYMMDD]  => :environment do |task, args|
    DailyWeatherData.run("history_#{args.YYYYMMDD}")
    "Sent jobs to Sidekiq for #{args.YYYYMMDD}."
  end

  task :daily => [ :get_solar_data, :get_weather_data ]
  
  task :weekly do
    if Date.today.wday == 0
      Rake::Task["weather:lookup_stations"].invoke
      Rake::Task["weather:update_all_closest_stations"].invoke
    end
  end

end