Geocoder.configure(
  :http_proxy => ENV['QUOTAGUARD_URL'], #.gsub(/^http:\/\//, ''),
  :timeout => 5
)