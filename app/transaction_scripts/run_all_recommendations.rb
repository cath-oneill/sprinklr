class RunAllRecommendations
  def self.run(date_string = nil)
    if date_string.nil?
      date = Date.today 
    else
      date = Date.parse(date_string)
    end

    #find all users who need a recommendation today
    day_num = date.wday
    users = User.joins(:yard).where(yards: {day_number: day_num})
    users.each do |user|
      #run them individually through a worker
      RecommendationWorker.perform_async(user.id, date_string)
    end

  end
end