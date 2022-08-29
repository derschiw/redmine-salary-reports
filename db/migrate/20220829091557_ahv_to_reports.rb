class AhvToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :ahv_provisional_assessment, :decimal
  end
end
