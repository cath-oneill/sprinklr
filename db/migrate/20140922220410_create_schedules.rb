class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :name
      
      t.integer :start_hr
      t.integer :start_min
      t.integer :end_hr
      t.integer :end_min
      t.string :day
      
      t.timestamps
    end
  end
end
