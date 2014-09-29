class SidekiqController < ApplicationController

  def monitor
    if current_user.id == 1 || current_user.id == 2
      mount Sidekiq::Web => '/sidekiq'
    else
      redirect_to "/"
    end
  end
end