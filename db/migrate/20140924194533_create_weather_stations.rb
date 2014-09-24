class CreateWeatherStations < ActiveRecord::Migration
  def change
    create_table :weather_stations do |t|
      t.decimal :latitude
      t.decimal :longitude
      t.string :kind
      t.string :code

      t.timestamps
    end
  end
end
