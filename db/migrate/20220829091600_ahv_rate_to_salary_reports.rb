class AhvRateToSalaryReports < ActiveRecord::Migration[5.2]
  def change
    add_column :salary_reports, :ahv_rate, :decimal
  end
end
