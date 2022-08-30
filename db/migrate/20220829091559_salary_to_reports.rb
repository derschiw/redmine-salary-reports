class SalaryToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :salary, :decimal
  end
end
