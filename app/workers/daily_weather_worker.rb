class DailyWeatherWorker
  include Sidekiq::Worker

  def perform(station_id, query = "yesterday")
    DailyWeatherDataByStation.run(station_id, query)
  end
end