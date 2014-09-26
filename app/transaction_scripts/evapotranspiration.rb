class Evapotranspiration

  def self.run(station_id, date)
    @station = WeatherStation.find(station_id)
    @day_of_year = date.yday
    @report = @station.weather_datas.find_by(date: date)
    @solar_radiation = SolarData.find_by(date: date).solar_reading
    sol_in_mm = et_wind + et_rad
    return sol_in_mm/25.4
  end  

  def self.slope_of_vapor
    step1 = 4098.0 * saturation_vapor(@report.mean_temperature)
    step2 = (@report.mean_temperature + 237.3)**2.0
    return step1/step2
  end

  def self.atmospheric_pressure
    elevation = 149 #average elevation of Austin in meters; plays a very minor role on evapotranspiration until high altitude
    step1 = (293.0 - (0.0065 * elevation)) / 293.0
    step2 = step1**5.26
    return 101.3 * step2 
  end

  def self.psychometric_constant
   return 0.000665 * atmospheric_pressure  
  end

  def self.delta_term
    step1 = psychometric_constant * (1.0 + (0.34 * @report.wind_speed))
    return  slope_of_vapor / (slope_of_vapor + step1)  
  end

  def self.psy_term
    step1 = psychometric_constant * (1.0 + (0.34 * @report.wind_speed))
    return psychometric_constant / (slope_of_vapor + step1)  
  end

  def self.temperature_term
   return (900.0 /(@report.mean_temperature + 273.0)) * @report.wind_speed  
  end

  def self.saturation_vapor(temp)
    step1 = (7.5 * temp) / (temp + 237.3)
    return 0.6108 * (10**(step1))  
  end

  def self.mean_saturation_vapor
   return (saturation_vapor(@report.minimum_temperature) + saturation_vapor(@report.maximum_temperature))/2.0  
  end

  def self.actual_vapor_pressure
   return saturation_vapor(@report.minimum_temperature) * (@report.maximum_humidity/100.0)  
  end

  def self.inverse_relative_distance_sun
    step1 = (2 * Math::PI * @day_of_year)/365
    return (Math.cos(step1) * 0.033) + 1  
  end

  def self.solar_declanation
    step1 = (2 * Math::PI * @day_of_year)/365
    step2 = step1 - 1.39
    return 0.409 * Math.sin(step2) 
  end

  def self.latitude_in_rads
   return  sol = (Math::PI/180) * @station.latitude 
  end

  def self.sunset_hour_angle
    return Math.acos(-1 * Math.tan(latitude_in_rads) * Math.tan(solar_declanation))
  end

  def self.extraterrestrial_radiation
    step1 = sunset_hour_angle * Math.sin(latitude_in_rads) * Math.sin(solar_declanation)
    step2 = Math.cos(latitude_in_rads) * Math.cos(solar_declanation) * Math.sin(sunset_hour_angle)
    step3 = (step1 + step2) * 1440.0 / Math::PI
    return step3 * 0.082 * inverse_relative_distance_sun
  end

  def self.clear_sky_solar_radiation
    elevation = 149 #average elevation of Austin in meters; plays a very minor role on evapotranspiration until high altitude
    step1 = 0.75 + (2.0 * (10.0 ** -5) * elevation)
    return step1 * extraterrestrial_radiation
  end

  def self.net_solar_radiation
    return 0.77 * @solar_radiation
  end

  def self.net_outgoing_radiation
    step1 = 1.35 * (net_solar_radiation/clear_sky_solar_radiation) - 0.35
    step2 = 0.34 - 0.14 * (Math.sqrt(actual_vapor_pressure))
    step3 = (@report.maximum_temperature + 273.16)**4 + (@report.minimum_temperature + 273.16)**4
    step4 = step3/2
    step5 = 4.903 * 10**-9
    return step5 * step4 * step1 * step2
  end

  def self.net_radiation
   return net_solar_radiation - net_outgoing_radiation    
  end

  def self.et_rad
    return delta_term * net_radiation * 0.408
  end

  def self.et_wind
    return psy_term * temperature_term * (mean_saturation_vapor - actual_vapor_pressure)
  end

end

