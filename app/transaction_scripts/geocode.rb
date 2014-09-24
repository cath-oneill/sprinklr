require 'net/http'
require 'json'

class Geocode
  def self.run(user_id, address, zip_code)
    addr = address.split(" ").join("%20")
    zip = zip_code.split(" ").join("%20")
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=%22#{addr}%20#{zip}%22"
    uri = URI(url)
    data = Net::HTTP.get(uri)
    json = JSON.parse(data)

    if json['status'] != 'OK'
      return :incomplete_address
    end
    
    latitude = json['results'][0]['geometry']['location']['lat']
    longitude = json['results'][0]['geometry']['location']['lng']

    user = User.find(user_id)
    user.latitude = latitude
    user.longitude = longitude
    user.save
  end
end