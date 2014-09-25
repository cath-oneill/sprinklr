require 'net/http'
require 'json'

class Geocode
  def self.run(user_id, address, zip_code)
    user = User.find(user_id)
    response = Geocoder.search("#{address} #{zip_code}")
    if geo = response.first
        user.formatted_address = geo.data['formatted_address']
        user.latitude = geo.latitude
        user.longitude = geo.longitude
    end
    user.save
  end
end