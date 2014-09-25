class CreateSolarData < ActiveRecord::Migration
  def change
    create_table :solar_data do |t|
      t.date :date
      t.float :solar_reading

      t.timestamps
    end
  end
end
