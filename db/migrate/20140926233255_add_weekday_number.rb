class AddWeekdayNumber < ActiveRecord::Migration
  def change
    add_column :yards, :day_number, :integer
  end
end
