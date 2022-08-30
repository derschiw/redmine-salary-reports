class AlvRateToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :alv_rate, :decimal
  end
end
