json.array!(@users) do |user|
  json.extract! user, :id, :name, :uid, :provider, :address, :zip, :latitude, :longitude, :contact_method, :email, :phone
  json.url user_url(user, format: :json)
end
