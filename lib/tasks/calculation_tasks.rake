namespace :calculate do
  task :eto, [:station_id, :date_string] => :environment do |t, args|
    station_id = args[:station_id]
    date = Date.parse(args[:date_string])
    eto = Evapotranspiration.run(station_id, date)
    EtoCalculation.create(
      weather_station_id: station_id,
      date: date,
      eto: eto)
  end
end