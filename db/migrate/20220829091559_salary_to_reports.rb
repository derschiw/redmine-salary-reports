class SalaryToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :salary, :decimal
  end
end
