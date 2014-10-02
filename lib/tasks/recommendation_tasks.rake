namespace :recommendations do
  #at command line: rake weather:recommendations_by_date[September,26,2014]
  task :get_by_date, [:month, :date, :year] => :environment do |task, args|
    RunAllRecommendations.run("#{args.month} #{args.date}, #{args.year}")
  end

  task :get => :environment do 
    RunAllRecommendations.run
  end

  task :test_sms => :environment do
    TextMsg.test
  end

  task :send_messages => :environment do
    SendAllMessages.run
  end

  task :update_user_closest_station, [:user_id] => :environment do |task, args|
    user = User.find("#{args.user_id}")
    FindClosestStation.run(user.latitude, user.longitude, user.id)
  end

end