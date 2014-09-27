require 'date'

class PrepareRecommendation

  def self.run
    #find all users who need a recommendation today
    day_num = 4 #Date.today.wday
    beginning_of_week = Date.today - 7
    end_of_week = Date.today - 1
    users = User.joins(:yard).where(yards: {day_number: day_num})

    #check if they have enough data
    users.each do |user|
      closest_sta = user.weather_station
      weather_reports = closest_sta.weather_datas.where(:date => beginning_of_week..end_of_week)
      eto_calcs = closest_sta.eto_calculations.where(:date => beginning_of_week..end_of_week)

      if weather_reports.length < 7
        (beginning_of_week..end_of_week).each do |date|
          unless weather_reports.any? {|x| x.date == date}
            query_string = "history_" + date.strftime("%Y%m%d")
            DailyWeatherData.run(query_string)
          end
        end
      end

    end

    #get missing data
    #make recommendation

  end
end