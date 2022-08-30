class CreateSalaryReports < ActiveRecord::Migration[5.2]
  def change
    create_table :salary_reports do |t|
      t.references :user, foreign_key: true
      t.datetime :date_from
      t.datetime :date_to
      t.decimal :overtime_ignoring_holidays
      t.decimal :overtime_considering_holidays
      t.decimal :holidays_taken
    end
  end
end
