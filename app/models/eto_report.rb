class EtoReport < ActiveRecord::Base
  belongs_to :eto_calculation
  belongs_to :recommendation
end
