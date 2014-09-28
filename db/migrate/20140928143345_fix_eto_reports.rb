class FixEtoReports < ActiveRecord::Migration
  def change
    remove_column :eto_reports, :etc_calculation_id, :integer
    add_reference :eto_reports, :eto_calculation, index: true
  end
end
