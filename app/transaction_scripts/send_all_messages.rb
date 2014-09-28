class SendAllMessages
  def self.run
    date = Date.today

    #find all users whose watering day is tomorrow and thus need a msg today
    day_num = (date + 1).wday
    users = User.joins(:yard).where(yards: {day_number: day_num})
    text_counter = 0
    email_counter = 0
    users.each do |user|
      return if user.contact_method == "decline" || user.contact_method == "no selection"
      recommendation = Recommendation.find_by(yard_id: user.yard.id, watering_day: date + 1)
      if user.contact_method == "text"
        #run them individually through a worker
        TextWorker.perform_async(user.id, recommendation.id)
        text_counter += 1
      elsif user.contact_method == "email"
        UserMailer.delay.weekly_email(user.id, recommendation.id)
        email_counter += 1
      end
    end
    puts "Sent #{text_counter} text jobs and #{email_counter} email jobs to sidekiq."

  end

end