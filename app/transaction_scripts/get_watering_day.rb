class GetWateringDay

  def self.run(yard, current_user)
    if yard.sprinkler.nil? || current_user.address.nil?
      return nil
    end

    street_number = current_user.address.split(" ").first.scan(/\d+/).join('').to_i
    
    if street_number.even? && yard.sprinkler == "automatic"
      return "Thursday"
    elsif street_number.odd? && yard.sprinkler == "automatic"
      return "Wednesday"
    elsif street_number.even? #hose-end sprinklers
      return "Sunday"
    elsif street_number.odd? #hose-end sprinklers
      return "Saturday"
    end
  end
end