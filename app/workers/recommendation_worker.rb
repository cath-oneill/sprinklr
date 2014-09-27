class RecommendationWorker
  include Sidekiq::Worker

  def perform(user_id, date_string = nil)
    PrepareRecommendation.run(user_id, date_string = nil)
  end
end