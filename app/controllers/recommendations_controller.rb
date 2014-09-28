class RecommendationsController < ApplicationController

  # GET /recommendations
  # GET /recommendations.json
  def index
    @user = current_user
    @yard = current_user.yard
    @recommendations = @yard.recommendations.order(created_at: :desc)
  end

  # GET /recommendations/1
  # GET /recommendations/1.json
  def show
    @user = current_user
    @yard = current_user.yard
    @recommendation = Recommendation.find(params[:id])
    @watering_date = @recommendation.created_at.to_date + 1 
    @reports = WeatherData.where(date: @watering_date-8..@watering_date-2, 
      weather_station_id: @user.weather_station_id).order(date: :desc)
  end

end
