require 'date'

class PrepareRecommendation

  def self.run
    #find all users who need a recommendation today
    day_num = Date.today.wday
    beginning_of_week = Date.today - 7
    end_of_week = Date.today - 1
    month = Date.today.month
    users = User.joins(:yard).where(yards: {day_number: day_num})

    #check if they have enough data
    users.each do |user|
      closest_sta = user.weather_station
      weather_reports = closest_sta.weather_datas.where(:date => beginning_of_week..end_of_week)
      eto_calcs = closest_sta.eto_calculations.where(:date => beginning_of_week..end_of_week)

      if weather_reports.length < 7
      #get missing data
        (beginning_of_week..end_of_week).each do |date|
          unless weather_reports.any? {|x| x.date == date}
            query_string = "history_" + date.strftime("%Y%m%d")
            DailyWeatherData.run(query_string)
          end
        end
      weather_reports = closest_sta.weather_datas.where(:date => beginning_of_week..end_of_week)
      eto_calcs = closest_sta.eto_calculations.where(:date => beginning_of_week..end_of_week)
      end

      weekly_precipitation = weather_reports.map{|x| x.precipitation}.inject(:+)
      weekly_eto = eto_calcs.map{|y| y.eto}.inject(:+)

      p user.name
      p weather_reports
      p eto_calcs
      puts "Total Precipitation:"
      p weekly_precipitation
      puts "Weekly ETO:"
      p weekly_eto

    monthly_turf_coefficient = {
      1 => 0.1,
      2 => 0.2, 
      3 => 0.3,
      4 => 0.6,
      5 => 0.6,
      6 => 0.6,
      7 => 0.6,
      8 => 0.6,
      9 => 0.6,
      10 => 0.6,
      11 => 0.3,
      12 => 0.1
    }


    quality_factor = {
     "buffalo" => [0.4, 0.6],
     "st_augustine" => [0.7, 1.0],
     "bermuda" => [0.5, 0.7],
     "zoysia" => [0.7, 1.0]
    }
      low_recommendation = weekly_eto * monthly_turf_coefficient[month] * quality_factor[user.yard.grass].first 
      high_recommendation = weekly_eto * monthly_turf_coefficient[month] * quality_factor[user.yard.grass].last 
      p low_recommendation
      p high_recommendation
      #make recommendation
      # weekly_eto = 
      # precipitation = 
      # Recommendation.create(
      #   yards_id: user.yard.id,
      #   inches: ,
      #   minutes: 
      #   )



    end

  end

end