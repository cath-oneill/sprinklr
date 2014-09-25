require 'date'
require 'nokogiri'
require 'open-uri'

class GetSolarData
  #Scraping a nasty old-school poorly formatted XML table
  def self.run
    url = "http://texaset.tamu.edu/date.php?stn=48&spread=14" 
    doc = Nokogiri::HTML(open(url))

    date_column = doc.at_css(".b1 td:nth-child(1)").text
    dates = date_column.scan(/201[0-9]-[0-9]{2}-[0-9]{2}/)
    
    solar_column = doc.at_css(".b1 td:nth-child(6)").text
    solar = solar_column.scan(/[0-9]{1,2}.[0-9]{2}/)
    
    zipped_data = dates.zip(solar)

    zipped_data.each do |pair|
      date_string = pair[0]
      date_object = Date.parse(date_string)
      solar_data = pair[1].to_f
      unless SolarData.find_by(date: date_object)
        SolarData.create(
          date: date_object,
          solar_reading: solar_data)
      end
    end
  end
end