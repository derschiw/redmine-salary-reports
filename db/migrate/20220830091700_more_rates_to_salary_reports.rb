class MoreRatesToSalaryReports < ActiveRecord::Migration[5.2]
  def change
    add_column :salary_reports, :pension_pool_rate, :decimal
    add_column :salary_reports, :nbu_rate, :decimal
    add_column :salary_reports, :nbu_rate_frac, :decimal
  end
end
