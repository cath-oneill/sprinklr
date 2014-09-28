class WeatherReport < ActiveRecord::Base
  belongs_to :weather_data
  belongs_to :recommendation
end
