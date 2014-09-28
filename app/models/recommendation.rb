class Recommendation < ActiveRecord::Base
  belongs_to :yards
  has_many :eto_reports
  has_many :eto_calculations, through: :eto_reports
  has_many :weather_reports
  has_many :weather_data, through: :weather_reports
end
