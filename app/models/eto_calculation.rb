class EtoCalculation < ActiveRecord::Base
  belongs_to :weather_station
  has_many :eto_reports
  has_many :recommendations, through: :eto_reports
end