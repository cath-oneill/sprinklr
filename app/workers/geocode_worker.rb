class GeocodeWorker
  include Sidekiq::Worker

  def perform(user_id, address, zip_code)
    Geocode.run(user_id, address, zip_code)
    user = User.find(user_id)
    FindClosestStation.run(user.latitude, user.longitude, user.id)
  end
end