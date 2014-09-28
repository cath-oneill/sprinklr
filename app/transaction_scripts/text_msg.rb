require 'twilio-ruby' 
 
class TextMsg

  def self.test
    # put your own credentials here 
    account_sid = "#{ENV['TWILIO_SID']}"
    auth_token = "#{ENV['TWILIO_AUTH_TOKEN']}"
    time = Time.now
    time = time.strftime("%H:%M %m-%d-%y")
     
    # set up a client to talk to the Twilio REST API 
    @client = Twilio::REST::Client.new account_sid, auth_token 
     
    @client.account.messages.create({
      :from => '+17372103472', 
      :to => '512-698-3322', 
      :body => "Test Message #{time}",  
    })
  end

  def self.run(user_id, recommendation_id)
    # put your own credentials here 
    account_sid = "#{ENV['TWILIO_SID']}"
    auth_token = "#{ENV['TWILIO_AUTH_TOKEN']}"
    user = User.find(user_id)
    recommendation = Recommendation.find(recommendation_id)
     
    # set up a client to talk to the Twilio REST API 
    @client = Twilio::REST::Client.new account_sid, auth_token 
     
    @client.account.messages.create({
      :from => '+17372103472', 
      :to => "#{user.phone}", 
      :body => "Hello from Sprinklr! Your watering day is tomorrow. You need to water #{recommendation.min_irrigation.round(2)} - #{recommendation.max_irrigation.round(2)} inches.",  
    })    
  end
end