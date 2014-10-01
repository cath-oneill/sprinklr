class WeatherController < ApplicationController

  def eto
    year = params[:YYYY]
    month = params[:MM]
    day = params[:DD]
    @eto = EtoCalculation.where(date: "#{month}-#{day}-#{year}")
    render json: @eto.as_json(include: [{weather_station: {only: [:latitude, :longitude]}}])
  end


end