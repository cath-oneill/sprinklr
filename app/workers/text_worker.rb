class TextWorker
  include Sidekiq::Worker

  def perform(user_id, recommendation_id)
    TextMsg.run(user_id, recommendation_id)
  end
end