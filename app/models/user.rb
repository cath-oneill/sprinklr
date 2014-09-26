class User < ActiveRecord::Base
  has_one :yard
  belongs_to :weather_station
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.login_email = auth["info"]["email"]
    end
    Yard.create(user_id: user.id)
  end
end
