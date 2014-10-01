class AddZipColumnToWeatherStation < ActiveRecord::Migration
  def change
    add_column :weather_stations, :zip, :string
  end
end
