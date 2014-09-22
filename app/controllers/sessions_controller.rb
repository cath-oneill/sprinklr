class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) 
    if user.nil?
      user = User.create_with_omniauth(auth)
      new_user = true
    end
    user.profile_pic = auth["info"]["image"]
    session[:user_id] = user.id
    user.save
    if new_user
      redirect_to edit_user_path(user), alert: "Welcome to sprinklr!"
    else
      redirect_to user_path(user)
    end
  end
 
  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
