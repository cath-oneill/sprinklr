require 'date'

class PrepareRecommendation

  def self.run(user_id, date_string = nil)
    user = User.find(user_id)
    if date_string.nil?
      date = Date.today 
    else
      date = Date.parse(date_string)
    end
    beginning_of_week = date - 7
    end_of_week = date - 1
    month = date.month

    #collect corresponding weather and eto data
    closest_sta = user.weather_station
    weather_reports = closest_sta.weather_datas.where(:date => beginning_of_week..end_of_week)
    eto_calcs = closest_sta.eto_calculations.where(:date => beginning_of_week..end_of_week)

    #use Bergstrom for any missing data
    while weather_reports.length < 7
      bergstrom = WeatherStation.find_by(code: "KAUS")
      (beginning_of_week..end_of_week).each do |date|
        unless weather_reports.any? {|x| x.date == date}
          weather_reports << bergstrom.weather_datas.find_by(date: date)
        end
      end
    end

    while eto_calcs.length < 7
      bergstrom = WeatherStation.find_by(code: "KAUS")
      (beginning_of_week..end_of_week).each do |date|
        unless eto_calcs.any? {|x| x.date == date}
          eto_calcs << bergstrom.eto_calculations.find_by(date: date)
        end
      end
    end

    recommendation = Recommendation.new 
    recommendation.yard_id = user.yard.id

    #sum of weekly precipitation and weekly eto
    recommendation.weekly_precipitation = weather_reports.map{|x| x.precipitation}.inject(:+)
    recommendation.weekly_eto = eto_calcs.map{|y| y.eto}.inject(:+)

    #Source: Texas A&M EvapoTranspiration Network
    #http://texaset.tamu.edu/documents/Turf%20Coeff.pdf
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

    #Compiled and extrapolated from several sources:
    #http://texaset.tamu.edu/coefs.php
    #http://abe.ufl.edu/mdukes/pdf/irrigation-efficiency/Romero_Dukes_Turfgrass%20ET_Crop_%20Coefficient_%20Lit.pdf
    #http://anrcatalog.ucdavis.edu/pdf/8395.pdf
    quality_factor = {
     "buffalo" => [0.4, 0.6],
     "st_augustine" => [0.7, 1.0],
     "bermuda" => [0.5, 0.7],
     "zoysia" => [0.7, 1.0]
    }

    #range of required water
    recommendation.min_req_water = recommendation.weekly_eto * monthly_turf_coefficient[month] * quality_factor[user.yard.grass].first 
    recommendation.max_req_water = recommendation.weekly_eto * monthly_turf_coefficient[month] * quality_factor[user.yard.grass].last 

    #range of needed irrigation
    recommendation.min_irrigation = recommendation.min_req_water - recommendation.weekly_precipitation
    recommendation.max_irrigation = recommendation.max_req_water - recommendation.weekly_precipitation
    
    recommendation.min_irrigation = 0 if recommendation.min_irrigation < 0
    recommendation.max_irrigation = 0 if recommendation.max_irrigation < 0

    if user.yard.sprinkler_flow.nil? 
      sprinkler_rate = 60
    else
      sprinkler_rate = user.yard.sprinkler_flow
    end

    recommendation.min_minutes = recommendation.min_irrigation * sprinkler_rate
    recommendation.max_minutes = recommendation.max_irrigation * sprinkler_rate
      
    #sprinkler rate calculation of minutes

    recommendation.save
    puts "Recommendation created for #{user.name}"
  end
end