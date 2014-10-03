  class Yard < ActiveRecord::Base
  belongs_to :user
  has_many :recommendations

  def calculate_sprinkler_flow
    if self.sprinkler_flow_minutes && self.sprinkler_flow_inches
      self.sprinkler_flow = self.sprinkler_flow_minutes / self.sprinkler_flow_inches
      self.save
    end
  end
end
