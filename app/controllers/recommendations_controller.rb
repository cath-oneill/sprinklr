class RecommendationsController < ApplicationController


  # GET /plan
  # GET /recommendation.json
  def current
    @user = current_user
    @yard = current_user.yard
    @recommendation = @yard.recommendations.order(created_at: :desc).first
    @weather_reports = @recommendation.weather_datas.order(date: :desc)
    @eto_reports = @recommendation.eto_calculations.order(date: :desc)
    render 'show'
  end

end
