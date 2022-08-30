class AhvRateToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :ahv_rate, :decimal
  end
end
