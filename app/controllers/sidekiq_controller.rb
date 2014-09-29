class SidekiqController < ApplicationController

  def monitor
    if current_user.id == 1 || current_user.id == 2
      render Sidekiq::Web 
    else
      redirect_to "/"
    end
  end
end