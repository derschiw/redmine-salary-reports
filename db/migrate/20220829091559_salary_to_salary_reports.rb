class SalaryToSalaryReports < ActiveRecord::Migration[5.2]
  def change
    add_column :salary_reports, :salary, :decimal
  end
end
