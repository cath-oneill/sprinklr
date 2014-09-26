class CreateEvapotranspiration < ActiveRecord::Migration
  def change
    create_table :eto_calculations do |t|
      t.date :date
      t.belongs_to :station
      t.float :eto
    end
  end
end
