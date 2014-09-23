require 'net/http'
require 'json'

class Geocode
  def self.run(user_params)
    addr = user_params[:address].split(" ").join("%20")
    zip = user_params[:zip].split(" ").join("%20")
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=%22#{addr}%20#{zip}%22"
    uri = URI(url)
    data = Net::HTTP.get(uri)
    json = JSON.parse(data)

    if json['status'] != 'OK'
      return :incomplete_address
    end
    
    user_params[:latitude] = json['results'][0]['geometry']['location']['lat']
    user_params[:longitude] = json['results'][0]['geometry']['location']['lng']

    return user_params
  end
end