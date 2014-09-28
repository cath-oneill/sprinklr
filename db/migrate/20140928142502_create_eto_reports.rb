class CreateEtoReports < ActiveRecord::Migration
  def change
    create_table :eto_reports do |t|
      t.belongs_to :recommendation
      t.belongs_to :etc_calculation
      t.timestamps
    end
  end
end
