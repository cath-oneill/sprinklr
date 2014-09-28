class WeatherData < ActiveRecord::Base
  belongs_to :weather_station
  has_many :weather_reports
  has_many :recommendations, through: :weather_reports
end
