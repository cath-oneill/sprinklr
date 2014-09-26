class ChangeColumnName < ActiveRecord::Migration
  def change
    add_reference :eto_calculations, :weather_station, index: true
    remove_column :eto_calculations, :station_id
  end
end
