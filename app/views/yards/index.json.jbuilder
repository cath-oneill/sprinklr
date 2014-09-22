json.array!(@yards) do |yard|
  json.extract! yard, :id
  json.url yard_url(yard, format: :json)
end
