class AhvToSalaryReports < ActiveRecord::Migration[5.2]
  def change
    add_column :salary_reports, :ahv_provisional_assessment, :decimal
  end
end
