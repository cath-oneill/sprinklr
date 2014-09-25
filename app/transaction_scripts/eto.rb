require 'date'

class Evapotranspiration
  #ALL VARIABLES FOR TRAVIS HEIGHTS LOCATION AND SEPTEMBER 23
  @@elevation = 0.0 #can probably be estimated -- in m
  @@latitude = 30.239292
  @@mean_temperature = (18.89 + 27.78)/2 #in celsius
  @@solar_radiation = 19.73 #in MJ/sq.m.
  @@mean_wind_speed = 1.80 #in m/s
  @@min_temperature = 18.89 #18.6
  @@max_temperature = 27.78 #30.7
  @@max_humidity = 88.00
  @@day_of_year = Date.new(2014,9,23).yday



  def self.slope_of_vapor
    step1 = 4098.0 * saturation_vapor(@@mean_temperature)
    puts step1
    step2 = (@@mean_temperature + 237.3)**2.0
    puts step2
    sol = step1/step2
    puts "Slope of Vapor: #{sol}"
    return sol
  end

  def self.atmospheric_pressure
    step1 = (293.0 - (0.0065 * @@elevation)) / 293.0
    step2 = step1**5.26
    sol = 101.3 * step2
    puts "Atmospheric Pressure: #{sol}"
    return sol 
  end

  def self.psychometric_constant
    sol = 0.000665 * atmospheric_pressure
    puts "Psychometric Constant: #{sol}"
    return sol  
  end

  def self.delta_term
    step1 = psychometric_constant * (1.0 + (0.34 * @@mean_wind_speed))
    sol =  slope_of_vapor / (slope_of_vapor + step1)
    puts "Delta Term: #{sol}"
    return sol  
  end

  def self.psy_term
    step1 = psychometric_constant * (1.0 + (0.34 * @@mean_wind_speed))
    sol = psychometric_constant / (slope_of_vapor + step1)
    puts "Psy Term: #{sol}"
    return sol  
  end

  def self.temperature_term
    sol = (900.0 /(@@mean_temperature + 273.0)) * @@mean_wind_speed
    puts "Temperature Term: #{sol}"
    return sol  
  end

  def self.saturation_vapor(temp)
    step1 = (7.5 * temp) / (temp + 237.3)
    sol =  0.6108 * (10**(step1))
    puts "Saturation Vapor at #{temp} degrees: #{sol}"
    return sol  
  end

  def self.mean_saturation_vapor
    sol = (saturation_vapor(@@min_temperature) + saturation_vapor(@@max_temperature))/2.0
    puts "Mean Saturation Vapor: #{sol}"
    return sol  
  end

  def self.actual_vapor_pressure
    sol = saturation_vapor(@@min_temperature) * (@@max_humidity/100.0)
    puts "Actual Vapor Pressure: #{sol}"
    return sol  
  end

  def self.inverse_relative_distance_sun
    step1 = (2 * Math::PI * @@day_of_year)/365
    sol = (Math.cos(step1) * 0.033) + 1
    puts "Inverse Relative Distance between Earth and Sun: #{sol}"
    return sol  
  end

  def self.solar_declanation
    step1 = (2 * Math::PI * @@day_of_year)/365
    step2 = step1 - 1.39
    sol = 0.409 * Math.sin(step2)
    puts "Solar Declanation: #{sol}"
    return sol 
  end

  def self.latitude_in_rads
    sol = (Math::PI/180) * @@latitude
    puts "Latitude in radians: #{sol}"
    return sol 
  end

  def self.sunset_hour_angle
    sol = Math.acos(-1 * Math.tan(latitude_in_rads) * Math.tan(solar_declanation))
    puts "Sunset Hour Angle: #{sol}"
    return sol
  end

  def self.extraterrestrial_radiation
    step1 = sunset_hour_angle * Math.sin(latitude_in_rads) * Math.sin(solar_declanation)
    step2 = Math.cos(latitude_in_rads) * Math.cos(solar_declanation) * Math.sin(sunset_hour_angle)
    step3 = (step1 + step2) * 1440.0 / Math::PI
    sol = step3 * 0.082 * inverse_relative_distance_sun
    puts "Extraterrestrial radiation: #{sol}"
    return sol
  end

  def self.clear_sky_solar_radiation
    step1 = 0.75 + (2.0 * (10.0 ** -5) * @@elevation)
    sol = step1 * extraterrestrial_radiation
    puts "Clear Sky Solar Radiation: #{sol}"
    return sol
  end

  def self.net_solar_radiation
    sol = 0.77 * @@solar_radiation
    puts "Net Solar Radiation: #{sol}"
    return sol
  end

  def self.net_outgoing_radiation
    step1 = 1.35 * (net_solar_radiation/clear_sky_solar_radiation) - 0.35
    step2 = 0.34 - 0.14 * (Math.sqrt(actual_vapor_pressure))
    step3 = (@@max_temperature + 273.16)**4 + (@@min_temperature + 273.16)**4
    step4 = step3/2
    step5 = 4.903 * 10**-9
    sol = step5 * step4 * step1 * step2
    puts "Net Outgoing Radiation: #{sol}"
    return sol
  end

  def self.net_radiation
    sol = net_solar_radiation - net_outgoing_radiation
    puts "Net Radiation: #{sol}"
    return sol    
  end

  def self.et_rad
    sol = delta_term * net_radiation * 0.408
    puts "ET Rad: #{sol}"
    return sol
  end

  def self.et_wind
    sol = psy_term * temperature_term * (mean_saturation_vapor - actual_vapor_pressure)
    puts "ET Wind: #{sol}"
    return sol
  end

  def self.run
    sol_in_mm = et_wind + et_rad
    sol = sol_in_mm/25.4
  end
end

p Evapotranspiration.run
