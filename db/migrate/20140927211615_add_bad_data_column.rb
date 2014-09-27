class AddBadDataColumn < ActiveRecord::Migration
  def change
    add_column :weather_stations, :bad_data, :boolean, :default => false
  end
end
