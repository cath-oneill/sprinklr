class RecommendationsController < ApplicationController


  # GET /recommendation
  # GET /recommendation.json
  def current
    @user = current_user
    @yard = current_user.yard
    @recommendation = @yard.recommendations.order(created_at: :desc).first
    @watering_date = @recommendation.created_at.to_date + 1 
    @reports = WeatherData.where(date: @watering_date-8..@watering_date-2, 
      weather_station_id: @user.weather_station_id).order(date: :desc)
    render 'show'
  end

end
