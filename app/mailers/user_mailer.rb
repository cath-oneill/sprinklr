class UserMailer < ActionMailer::Base
  default from: "atx.sprinklr@gmail.com"

  def welcome_email_success(user_id)
    @user = User.find(user_id)
    @url  = 'http://atx-sprinklr.herokuapp.com'
    mail(to: @user.email, subject: 'Welcome to Sprinklr')
  end  

end
