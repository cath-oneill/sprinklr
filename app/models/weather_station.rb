class WeatherStation < ActiveRecord::Base
  reverse_geocoded_by :latitude, :longitude
  has_many :users
end
