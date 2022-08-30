class AhvToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :ahv_provisional_assessment, :decimal
  end
end
