namespace :user do
  task :geocode, [:user_id] => :environment do |task, args|
    user = User.find("#{args.user_id}")
    GeocodeWorker.perform_async(user.id, user.address, user.zip)
  end

  task :update_closest_station, [:user_id] => :environment do |task, args|
    user = User.find("#{args.user_id}")
    FindClosestStation.run(user.latitude, user.longitude, user.id)
  end

end