namespace :calculate do
  #call rake calculate:specific_eto[4,20140925]
  task :specific_eto, [:station_id, :date_string] => :environment do |t, args|
    station_id = args[:station_id]
    date = Date.parse(args[:date_string])
    Evapotranspiration.run(station_id, date)
  end



end