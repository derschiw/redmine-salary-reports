class MoreRatesToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :pension_pool_rate, :decimal
    add_column :reports, :nbu_rate, :decimal
    add_column :reports, :nbu_rate_frac, :decimal
  end
end
