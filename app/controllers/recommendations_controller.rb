class RecommendationsController < ApplicationController

  # GET /recommendations
  # GET /recommendations.json
  def index
    @user = current_user
    @yards = current_user.yards
    @recommendations = @yards.map {|x| x.recommendations}
  end

  # GET /recommendations/1
  # GET /recommendations/1.json
  def show
    @recommendation = Recommendation.find(params[:id])
  end

end
