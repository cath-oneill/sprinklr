class RecommendationsController < ApplicationController


  # GET /plan
  # GET /recommendation.json
  def current
    @user = current_user
    @yard = current_user.yard
    @recommendation = @yard.recommendations.order(created_at: :desc).first
    if @recommendation
      @weather_reports = @recommendation.weather_datas.order(date: :desc)
      @eto_reports = @recommendation.eto_calculations.order(date: :desc)
      render 'show'
    else
      redirect_to profile_path, notice: "You do not have a recommendation yet.  Make sure you have entered all your information, and we will send you one soon!"
    end
  end

end
