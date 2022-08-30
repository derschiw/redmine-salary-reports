class AddSetupToSalaryReports < ActiveRecord::Migration[5.2]
  def change
    add_column :salary_reports, :week_hours, :decimal
    add_column :salary_reports, :weeks_of_per_year, :decimal
    add_column :salary_reports, :days_of_per_year, :decimal
    add_column :salary_reports, :start_date, :datetime
    add_column :salary_reports, :workload, :decimal
  end
end
