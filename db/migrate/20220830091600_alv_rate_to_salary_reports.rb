class AlvRateToSalaryReports < ActiveRecord::Migration[5.2]
  def change
    add_column :salary_reports, :alv_rate, :decimal
  end
end
