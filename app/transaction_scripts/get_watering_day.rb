class GetWateringDay

  def self.run(yard, current_user)
    if yard.sprinkler.nil? || current_user.address.nil?
      yard.day = nil
    else

      street_number = current_user.address.split(" ").first.scan(/\d+/).join('').to_i
      
      if street_number.even? && yard.sprinkler == "automatic"
        yard.day = "Thursday"
        yard.day_number = 4
      elsif street_number.odd? && yard.sprinkler == "automatic"
        yard.day = "Wednesday"
        yard.day_number = 3
      elsif street_number.even? #hose-end sprinklers
        yard.day = "Sunday"
        yard.day_number = 0
      elsif street_number.odd? #hose-end sprinklers
        yard.day = "Saturday"
        yard.day_number = 6
      end
    end
    yard.save
  end
end