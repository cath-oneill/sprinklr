class User < ActiveRecord::Base
  has_one :yard
  belongs_to :weather_station
  
  def self.create_with_omniauth(auth)
    user = User.create(
      provider: auth["provider"],
      uid: auth["uid"],
      name: auth["info"]["name"],
      email: auth["info"]["email"],
      login_email: auth["info"]["email"],
      yard: Yard.create
    )
    UserMailer.delay_for(60.minutes).welcome(user.id)
  end

  def missing_info?
    return true if self.address.nil?
    return true if self.zip.nil?
    return true if self.contact_method == "no selection"
    return true if self.contact_method == "text" && self.phone.nil?
    return true if self.yard.grass.nil?
    return true if self.yard.sprinker.nil?
    false
  end
end
