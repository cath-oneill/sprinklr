class UserMailer < ActionMailer::Base
  default from: "atx.sprinklr@gmail.com"

  def welcome(user_id)
    @user = User.find(user_id)
    @yard = user.yard
    @url  = 'http://atx-sprinklr.herokuapp.com'
    mail(to: @user.email, subject: 'Welcome to Sprinklr')
  end  

  def weekly_email(user_id, recommendation_id)
    @user = User.find(user_id)
    @recommendation = Recommendation.find(recommendation_id)
    @url  = 'http://atx-sprinklr.herokuapp.com'
    mail(to: @user.email, subject: 'Sprinklr - Don\'t forget to water tomorrow!')
  end

end
