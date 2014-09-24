namespace :weather do
  task :lookup_stations do
    puts "I'm going to look up some weather stations."
  end

  task :get_weather_data do
    puts "Get some weather data info!"
  end

  task :all => [:lookup_stations, :get_weather_data]
end