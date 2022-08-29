class Report < ActiveRecord::Base

  WEEKS_PER_YEAR = 52.2

  belongs_to :user
  before_create :setup

  # Setup a report using the current settings.
  def setup
    self.week_hours = Setting.plugin_reports[:week_hours]
    self.weeks_of_per_year = Setting.plugin_reports[:weeks_of_per_year] 
    self.days_of_per_year = Setting.plugin_reports[:days_of_per_year] 
    self.start_date = self.user.custom_field_values.select{|v| v.custom_field.name == "Employment Date"}.first.value
    self.workload = self.user.custom_field_values.select{|v| v.custom_field.name == "Workload"}.first.value.to_f * 0.01
    self.save!
  end

  # Fraction of year considered in the report
  def frac(date_from)
    delay = (self.date_to - date_from) / 24 / 3600
    delay / 365 
  end

  # Calculate the total number of working hours per year.
  def working_hours_per_year
    WEEKS_PER_YEAR * self.week_hours
  end

  # Returns the date, when person started working or beginning of year.
  def employment_date
    if self.start_date.nil? or self.start_date < Date.today.at_beginning_of_year
      return Date.today.at_beginning_of_year.to_time
    else
      return self.start_date
    end
  end
  
  # Hours worked during period
  def working_hours(date_from = self.date_from)
    TimeEntry.where(user: self.user, spent_on: date_from..self.date_to).sum{|t| t.hours }
  end
  
  # Hours worked during period ignoring holidays and days of
  def working_hours_ignoring_holidays(date_from = self.date_from)
    TimeEntry.where(user: self.user, spent_on: date_from..self.date_to).sum{|t| !["Ferien", "Feiertag"].include?(t.activity.name)  ? t.hours : 0}
  end

  def calc_overtime_ignoring_holidays(date_from = self.date_from)
    goalTot =  self.working_hours_per_year - (self.weeks_of_per_year * self.week_hours + self.days_of_per_year * self.week_hours / 5)
    goal = self.workload * goalTot * frac(date_from)
    self.working_hours_ignoring_holidays(date_from) - goal
  end
  
  def calc_overtime_considering_holidays(date_from = self.date_from)
    goalTot =  self.working_hours_per_year
    goal = self.workload * goalTot * frac(date_from)
    self.working_hours(date_from) - goal
  end
  
  def calc_holidays_taken(date_from = self.date_from)
    TimeEntry.where(user: self.user, spent_on: date_from..self.date_to).sum{|t| "Ferien" == t.activity.name ? t.hours : 0}
  end

  def calc_percentage_holidays_taken
    100 * (self.calc_holidays_taken / (self.weeks_of_per_year * self.week_hours * self.workload))
  end

end
