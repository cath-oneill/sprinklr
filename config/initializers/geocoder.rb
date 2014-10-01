
if Rails.env.production?
  Geocoder.configure(
    :http_proxy => ENV['QUOTAGUARD_URL'], #.gsub(/^http:\/\//, ''),
    :timeout => 5,
    :use_https => true,
    :api_key => "#{ENV['GOOGLE_API_KEY']}",
    :lookup => :google
  )
end