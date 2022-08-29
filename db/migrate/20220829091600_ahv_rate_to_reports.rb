class AhvRateToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :ahv_rate, :decimal
  end
end
