class AddSetupToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :week_hours, :decimal
    add_column :reports, :weeks_of_per_year, :decimal
    add_column :reports, :days_of_per_year, :decimal
    add_column :reports, :start_date, :datetime
    add_column :reports, :workload, :decimal
  end
end
