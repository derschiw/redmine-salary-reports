class MoreRatesToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :pension_pool_rate, :decimal
    add_column :reports, :nbu_rate, :decimal
    add_column :reports, :nbu_rate_frac, :decimal
  end
end
