class AlvRateToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :alv_rate, :decimal
  end
end
