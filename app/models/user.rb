class User < ActiveRecord::Base
  has_one :yard
  belongs_to :weather_station
  
  def self.create_with_omniauth(auth)
    User.create(
      provider: auth["provider"],
      uid: auth["uid"],
      name: auth["info"]["name"],
      email: auth["info"]["email"],
      login_email: auth["info"]["email"],
    )
    Yard.create(user_id: user.id)
  end
end
