class GeocodeWorker
  include Sidekiq::Worker

  def perform(user_id, address, zip_code)
    Geocode.run(user_id, address, zip_code)
  end
end