class RecommendationsController < ApplicationController

  # GET /recommendations
  # GET /recommendations.json
  def index
    @user = current_user
    @yard = current_user.yard
    @recommendations = @yard.recommendations
  end

  # GET /recommendations/1
  # GET /recommendations/1.json
  def show
    @recommendation = Recommendation.find(params[:id])
  end

end
